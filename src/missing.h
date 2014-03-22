/*
 * Copyright (c) 2014 NARUSE, Yui <naruse@airemix.jp>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
#define _GNU_SOURCE

#include <config.h>
#include <stddef.h>
#include <stdint.h>

#ifndef HAVE_EXPLICIT_BZERO
void explicit_bzero(void *p, size_t n);
#endif
#ifndef HAVE_TIMINGSAFE_BCMP
int timingsafe_bcmp(const void *b1, const void *b2, size_t n);
#endif
#ifndef HAVE_BCRYPT_PBKDF
int bcrypt_pbkdf(const char *pass, size_t passlen, const uint8_t *salt,
    size_t saltlen, uint8_t *key, size_t keylen, unsigned int rounds);
#endif
#ifndef HAVE_STRLCPY
size_t strlcpy(char *dst, const char *src, size_t siz);
#endif

#ifndef HAVE_ARC4RANDOM
void arc4random_buf(void *buf, size_t n);
/* signify isn't multithreaded */
# define _ARC4_LOCK()
# define _ARC4_UNLOCK()
#endif

#define SHA2_SMALL

#ifndef TCSASOFT
# define  TCSASOFT 0
#endif
