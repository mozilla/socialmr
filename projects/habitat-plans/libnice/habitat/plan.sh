pkg_name=libnice
pkg_origin=mozillareality
pkg_maintainer="Mozilla Mixed Reality <mixreality@mozilla.com>"

pkg_version="0.1.14"
pkg_license=('MPL')
pkg_source="https://github.com/libnice/libnice/archive/0.1.14.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="28a2ccf03ac7f59fe10094e711ef777659db3c90c04d06c85b23b232626b7902"
pkg_build_deps=(
  core/make
  core/gcc
  core/which
  core/libtool
  core/m4
  core/automake
  core/autoconf
  core/pkg-config
  mozillareality/autoconf-archive
)
pkg_description="Libnice is an implementation of the IETF's Interactive Connectivity Establishment (ICE) standard (RFC 5245)"
pkg_upstream_url="https://nice.freedesktop.org/wiki/"

do_build() {
  PKG_NAME=libnice
  aclocal --install
  autoreconf --force --install
  ./configure --prefix=${pkg_prefix}
  make
}
