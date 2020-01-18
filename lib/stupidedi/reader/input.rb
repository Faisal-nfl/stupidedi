# frozen_string_literal: true
# encoding: utf-8
module Stupidedi
  using Refinements

  module Reader
    #
    # This class maintains the current position within the input stream as its
    # consumed, and it also maintains an index (wavelet tree) that is used to
    # efficiently locate particular characters of interest, like X12 separators.
    #
    # @private
    class Input
      include Inspect

      # @return [Substring]
      attr_reader :pointer

      # @return [Position]
      attr_reader :position

      def_delegators :@pointer, :head, :defined_at?, :empty?, :[], :to_s,
        :take, :index, :=~, :==, :at, :encoding, :offset, type: Substring

      def initialize(pointer, position)
        @pointer  = pointer
        @position = position
        @index    = nil
      end

      # @endgroup
      #########################################################################

      def reindex(alphabet)
        @index = WaveletTree.build(@pointer, alphabet)
      end

      def deindex
        @index = nil
      end

      def _index(symbol, offset = 0)
        return index(symbol, offset) if @index.nil?

        # How many times does symbol occur *before* offset?
        n = @index.rank(symbol, @pointer.offset + offset)

        # Get location of n+1'th occurence of symbol
        m = @index.select(symbol, n)
        m and m - @pointer.offset
      end

      # @return self
      def drop!(n)
        unless n.zero?
          case @position
          when Position::NoPosition
            # Optimization (don't allocate a pointer)
          when Integer
            # Optimization (don't allocate a pointer)
            @position += n
          else
            @position = @position.advance(@pointer.take(n))
          end

          @pointer.drop!(n)
        end

        self
      end

      # Calculates the position at the given offset.
      #
      # @return [Position]
      def position_at(offset)
        offset = @pointer.length - 1 if offset >= @pointer.length

        case @position
        when Position::NoPosition
          # Optimization (don't allocate a pointer)
          @position
        when Integer
          # Optimization (don't allocate a pointer)
          @position + offset
        else
          @position.advance(@pointer.take(offset))
        end
      end

      # @return [Boolean]
      def start_with?(other, offset=0)
        other and @pointer.start_with?(other, offset)
      end

      # Returns true if the character at the given offset is a control
      # character (defined by X222.pdf B.1.1.2.4 Control Characters)
      #
      # @return [Boolean]
      def graphic?(offset)
        @pointer.graphic?(offset)
      end

      # Remove leading control characters
      #
      # @return self
      def lstrip_nongraphic!(offset = 0)
        drop!(@pointer.min_graphic_index(offset))
      end

      # Returns the offset of the next non-control character at or after offset
      #
      # @return [Integer]
      def min_graphic_index(offset = 0)
        @pointer.min_graphic_index(offset)
      end
    end

    class << Input
      # @group Constructors
      #########################################################################

      # @example
      #   Input.build(File.open("sample.edi"), mode: "rb")
      #   Input.build(File.read("sample.edi", encoding: "UTF-8"))
      #   Input.build(Pathname.new("sample.edi"), position: Position::OffsetPosition)
      #
      def build(value, *args)
        if x = String.try_convert(value)
          string(x, *args)

        elsif value.is_a?(Input)
          value

        elsif value.is_a?(Pathname)
          file(value, *args)

        elsif value.respond_to?(:read) or x = IO.try_convert(value)
          value    = x unless x.nil?
          position = args.last.delete(:position) if args.last.is_a?(Hash)
          path     = value.path if value.respond_to?(:path)
          content  = value.read

          # This will throw Encoding::InvalidByteSequenceErorr
          content.encode("binary") unless content.valid_encoding?
          new(Slice.build(content), (position || Position::NoPosition).build(path))
        else
          raise TypeError,
            "value must be a String, Pathname, or respond to #read"
        end
      end

      #
      # @example
      #   Input.file("example.edi", length, offset)
      #   Input.file("example.edi", mode: "rb")
      #   Input.file("example.edi", encoding: "US-ASCII")
      #   Input.file("example.edi", position: Position::NoPosition)
      #
      def file(path, *args)
        position =
          if args.last.is_a?(Hash)
            args.last.delete(:position)
          end || Position::NoPosition

        content = File.read(path, *args)

        # This will throw Encoding::InvalidByteSequenceErorr
        content.encode("binary") unless content.valid_encoding?

        new(Slice.build(content), position.build(path))
      end

      # @example
      #   Input.string(io.read)
      #   Input.string("...", position: Position::OffsetPosition)
      #
      def string(content, *args)
        position =
          if args.last.is_a?(Hash)
            args.last.delete(:position)
          end || Position::NoPosition

        # This will throw Encoding::InvalidByteSequenceErorr
        content.encode("binary") unless content.valid_encoding?

        new(Slice.build(content), position.build(nil))
      end

      # @endgroup
      #########################################################################
    end
  end
end
