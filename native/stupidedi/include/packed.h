#ifndef STUPIDEDI_PACKED_H_
#define STUPIDEDI_PACKED_H_

#include <stdint.h>
#include <stddef.h>
#include "bitstr.h"

#define STUPIDEDI_PACKED_WIDTH_MIN 1
#define STUPIDEDI_PACKED_WIDTH_MAX 64

typedef struct stupidedi_packed_t
{
    stupidedi_bitstr_t* data;
    uint8_t width;
    size_t length;
} stupidedi_packed_t;

/*****************************************************************************/

stupidedi_packed_t*
stupidedi_packed_alloc(size_t length, size_t width);

stupidedi_packed_t*
stupidedi_packed_dealloc(stupidedi_packed_t*);

stupidedi_packed_t*
stupidedi_packed_init(stupidedi_packed_t*, size_t length, size_t width);

stupidedi_packed_t*
stupidedi_packed_deinit(stupidedi_packed_t*);

stupidedi_packed_t*
stupidedi_packed_copy(const stupidedi_packed_t*, stupidedi_packed_t*);

stupidedi_packed_t*
stupidedi_packed_resize(stupidedi_packed_t*, size_t);

/*****************************************************************************/

size_t
stupidedi_packed_sizeof(const stupidedi_packed_t*);

size_t
stupidedi_packed_length(const stupidedi_packed_t*);

char*
stupidedi_packed_to_string(const stupidedi_packed_t*);

stupidedi_bitstr_t*
stupidedi_packed_as_bitstr(const stupidedi_packed_t*, stupidedi_bitstr_t*);

stupidedi_packed_t*
stupidedi_bitstr_as_packed(stupidedi_bitstr_t*, size_t width, stupidedi_packed_t*);

/*****************************************************************************/

uint64_t
stupidedi_packed_read(const stupidedi_packed_t*, size_t);

size_t
stupidedi_packed_write(const stupidedi_packed_t*, size_t, uint64_t value);

#endif
