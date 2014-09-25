#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.59)
AC_INIT(signify, 0.1, https://github.com/nurse/signify)
AC_CONFIG_SRCDIR([src/signify.c])
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([-Wportability foreign 1.9])
AC_CONFIG_HEADER([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.
AC_SEARCH_LIBS(__b64_ntop, c resolv, [], [
		AC_CHECK_LIB(resolv, res_9_b64_ntop)])

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([fcntl.h limits.h netinet/in.h paths.h stddef.h stdint.h stdlib.h string.h sys/param.h sys/time.h termios.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_C_INLINE
AC_TYPE_MODE_T
AC_TYPE_OFF_T
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_C_VOLATILE

# Checks for library functions.
AC_FUNC_SELECT_ARGTYPES
AC_REPLACE_FUNCS([timingsafe_bcmp explicit_bzero bcrypt_pbkdf])
AC_CACHE_CHECK(whether b64_pton is broken, rb_cv_broken_b64_pton,
  [AC_TRY_RUN([
#include <netinet/in.h>
#include <resolv.h>
int main(void) {
    char const *str = "p1v3+nehH3N3n+/OokzXpsyGF2VVpxIxkjSn3Mv/Sq74" \
      "OE1iFuVU+K4bQImuVjS55RB2fpCpbB8Nye7tzrt6h9YPP3yyJfqORDETGmIB4lve" \
      "ZXA4KDxx50F9rYrOdFbTLyWfNBb/8Q2TnD72eY/3Y5P9qwtJwyDL25Tleic8G3g=";
    u_char buf[128];
    return(b64_pton(str, buf, 128) == 128);
}
],
	rb_cv_broken_b64_pton=yes,
	rb_cv_broken_b64_pton=no,
	rb_cv_broken_b64_pton=yes)])
if test "$rb_cv_broken_b64_pton" = yes; then
	AC_LIBOBJ(b64_pton)
fi

AC_CONFIG_FILES([Makefile
                 src/Makefile])
AC_OUTPUT
