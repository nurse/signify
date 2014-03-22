#!/bin/sh
# use this when you want to follow OpenBSD upstream

download() {
  for f in \
    include/readpassphrase.h \
    include/sha2.h \
    lib/libc/crypt/arc4random.c \
    lib/libc/gen/readpassphrase.c \
    lib/libc/hash/sha2.c \
    lib/libc/hash/helper.c \
    lib/libc/net/base64.c \
    lib/libutil/bcrypt_pbkdf.c \
    usr.bin/signify/crypto_api.c \
    usr.bin/signify/mod_ed25519.c \
    usr.bin/signify/mod_ge25519.c \
    usr.bin/signify/signify.1 \
    usr.bin/signify/signify.c \
    usr.bin/ssh/crypto_api.h \
    usr.bin/ssh/fe25519.c \
    usr.bin/ssh/fe25519.h \
    usr.bin/ssh/sc25519.c \
    usr.bin/ssh/ge25519.h \
    usr.bin/ssh/ge25519_base.data \
    usr.bin/ssh/smult_curve25519_ref.c \
    sys/crypto/blf.c \
    sys/crypto/blf.h \
    sys/lib/libkern/explicit_bzero.c \
    sys/lib/libkern/timingsafe_bcmp.c
  do
    fetch -o src/${f##*/} 'http://www.openbsd.org/cgi-bin/cvsweb/src/'$f'?rev=HEAD;content-type=text%2Fplain'
  done
  mv src/readpassphrase.h src/_readpassphrase.h
  mv src/base64.c src/b64_pton.c
}

replace() {
  for f in signify.c bcrypt_pbkdf.c blf.c readpassphrase.c ; do \
    sed -i.obsd \
    -e's/<crypto\/blf.h>/<blf.h>/g' \
    -e'/#include <sys\/systm.h>/d' \
    -e'/#include <util.h>/d' \
    -e'/#include <readpassphrase.h>/{
  i\
#ifdef HAVE_READPASSPHRASE
  p
  i\
#else
  i\
#include "_readpassphrase.h"
  i\
#endif
  i\
#ifndef RPP_STDIN
  i\
# define RPP_STDIN 0
  i\
#endif
  d
}' \
    src/$f; \
    rm src/$f.obsd; \
  done
  sed -i.obsd \
    -e'
/^char/,/^}/{
  N
  /^.*\ngetpass(/,/^}/{
    /^.*getpass.*/{
      h
      s//#if 0/p
      x
    }
    /^}/{
      P
      s//#endif/
    }
  }
}' src/readpassphrase.c
  sed -i.obsd -e'/VSTATUS/{N;h;s/.*/#if 0/p;x;p;s/.*/#endif/;}' src/readpassphrase.c
  rm src/readpassphrase.c.obsd
  patch < build-aux/arc4random.c.patch
  rm src/arc4random.c.orig
}

download
replace