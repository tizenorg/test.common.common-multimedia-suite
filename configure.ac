AC_INIT([gst-auto-launch], [0.3.21], [tigrux@gmail.com], [gst-auto-launch])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS(config.h)
AM_INIT_AUTOMAKE([foreign])

AC_PROG_CC
#AC_PROG_LIBTOOL
#AC_DISABLE_STATIC

AC_PATH_PROG(VALAC, valac, valac)
AC_SUBST(VALAC)

AC_SUBST(CFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

VALAFLAGS="--pkg gstreamer-1.0 --pkg gstreamer-base-1.0 --pkg posix"
AC_SUBST(VALAFLAGS)

PKG_CHECK_MODULES(PROGRAM, gstreamer-1.0 gstreamer-base-1.0 gthread-2.0)
AC_SUBST(PROGRAM_CFLAGS)
AC_SUBST(PROGRAM_LIBS)

AC_CONFIG_FILES([
	Makefile
	ivi/gst-auto-launch/src/Makefile
	])

AC_OUTPUT
