class Quickcheck
  class Property
    # @return [String]
    attr_reader :name

    # @return [Class<Quickcheck>]
    attr_reader :qc

    # @return [Class]
    attr_reader :base

    # @return [Proc]
    attr_reader :setup

    def initialize(base, qc, *args, &setup)
      @base, @qc, @args, @setup =
        base, qc, args, setup
    end

    # @return [void]
    def check(cases = 100, limit = 10, &block)
      property = self

      if @args.last.is_a?(Hash)
        args = @args.slice(0..-2)
        hash = @args.last
        hash[:random] = true

        args << hash
      else
        args = @args
        args << Hash[:random => true]
      end

      @base.it(*args) do
        if property.setup.nil?
          skip
        end

        count = 0

        if block.nil?
          begin
            property.qc.generate(cases, limit, property.setup) do
              count += 1
              property.progress(count, cases)
            end
          rescue => e
            seed = srand # Get the previous seed by setting it
            srand(seed)  # But immediately restore it

            e.message << " -- with srand #{seed} after #{count} successes"
            raise e
          end
        elsif block.arity == 1
          property.qc.generate(cases, limit, property.setup) do |input|
            begin
              instance_exec(input, &block)

              count += 1
              property.progress(count, cases)
            rescue => e
              seed = srand # Get the previous seed by setting it
              srand(seed)  # But immediately restore it

              e.message << " -- with srand #{seed} after #{count} successes, input: #{input.inspect}"
              raise e
            end
          end

        else
          property.qc.generate(cases, limit, property.setup) do |input|
            begin
              instance_exec(*input, &block)

              count += 1
              property.progress(count, cases)
            rescue => e
              seed = srand # Get the previous seed by setting it
              srand(seed)  # But immediately restore it

              e.message << " -- with srand #{seed} after #{count} successes, input: #{input.inspect}"
              raise e
            end
          end
        end
      end
    end

    PROGRESS = %w(/ - \\ |)

    if $stdout.tty?
      def progress(completed, total)
        print((completed == total) ? "" : "#{PROGRESS[completed % PROGRESS.size]}\b")
      end
    else
      def progress(completed, total)
      end
    end
  end
end
