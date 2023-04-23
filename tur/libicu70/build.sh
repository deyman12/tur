TERMUX_PKG_HOMEPAGE=http://site.icu-project.org/home
TERMUX_PKG_DESCRIPTION='International Components for Unicode library'
TERMUX_PKG_LICENSE="BSD"
# We override TERMUX_PKG_SRCDIR termux_step_post_get_source so need to do
# this hack to be able to find the license file.
TERMUX_PKG_LICENSE_FILE="../LICENSE"
TERMUX_PKG_MAINTAINER="@deyman12"
TERMUX_PKG_VERSION=70.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/unicode-org/icu/releases/download/release-70-1/icu4c-70_1-src.tgz
TERMUX_PKG_SHA256=8d205428c17bf13bb535300669ed28b338a157b1c01ae66d31d0d3e2d47c3fd5
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-samples --disable-tests"
_INSTALL_PREFIX="$TERMUX_PREFIX/opt/$TERMUX_PKG_NAME"
TERMUX_PKG_STATICSPLIT_EXTRA_PATTERNS="$_INSTALL_PREFIX/lib/**/*.a $_INSTALL_PREFIX/lib/**/*.la"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-samples
--disable-tests
--disable-tools
--disable-extra
--prefix=$_INSTALL_PREFIX
--libdir=$_INSTALL_PREFIX/lib
--sbindir=$_INSTALL_PREFIX/bin
--with-library-suffix=${TERMUX_PKG_VERSION%%.*}
--with-cross-build=$TERMUX_PKG_HOSTBUILD_DIR
"

termux_step_post_get_source() {
	TERMUX_PKG_SRCDIR+="/source"
	find . -type f | xargs touch
}

termux_step_post_make_install() {
    find "$_INSTALL_PREFIX/lib" -name "*.so*" -exec ln -sfr "{}" "$TERMUX_PREFIX/lib" \;
	echo 
	echo "success installed libicu 70, by t.me/dvinchii";
	echo
}
