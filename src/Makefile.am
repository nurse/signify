bin_PROGRAMS = signify
signify_SOURCES = signify.c fe25519.c sc25519.c smult_curve25519_ref.c \
		  sha2.c sha256hl.c sha512hl.c \
		  mod_ed25519.c mod_ge25519.c crypto_api.c blf.c
EXTRA_signify_SOURCES = helper.c ge25519_base.data
noinst_HEADERS = blf.h sha2.h crypto_api.h fe25519.h \
		  ge25519.h missing.h _readpassphrase.h sc25519.h \
		  chacha_private.h
AM_CFLAGS += -include missing.h

signify_LDADD = $(LIBOBJS) $(ALLOCA)
dist_man_MANS = signify.1

sha256hl.c sha512hl.c: helper.c
	sed -e 's/hashinc/sha2.h/g' \
	    -e 's/HASH/SHA'$(@:hl.c=)'/g' \
	    -e 's/SHAsha/SHA/g' \
	    -e 's/<sha2.h>/"sha2.h"/g' \
	    -e 's/SHA[0-9][0-9][0-9]_CTX/SHA2_CTX/g' \
	    helper.c > $@
