pkg_name=libnice
pkg_origin=mozillareality
pkg_maintainer="Mozilla Mixed Reality <mixreality@mozilla.com>"

pkg_version="0.1.14"
pkg_license=('MPL')
pkg_source="https://nice.freedesktop.org/releases/libnice-${pkg_version}.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="be120ba95d4490436f0da077ffa8f767bf727b82decf2bf499e39becc027809c"
pkg_build_deps=(
  core/make
  core/gcc
  core/pkg-config
  mozillareality/p11-kit
)
pkg_deps=(
  core/glib
  mozillareality/gnutls
  mozillareality/nettle
  mozillareality/libtasn1
  mozillareality/pcre
)

pkg_description="Libnice is an implementation of the IETF's Interactive Connectivity Establishment (ICE) standard (RFC 5245)"
pkg_upstream_url="https://nice.freedesktop.org/wiki/"

do_build() {
  ./configure --prefix=${pkg_prefix}

  # This is a hack -- there is a name conflict between socket.h in gnutls and
  # socket.h in the libnice/socket directory, and the included
  # Makefile.am/Makefile ends up preferring the former instead of the latter
  # due to the order of the various include overrides.
  INCLUDES=-I/hab/cache/src/libnice-${pkg_version}/socket make -e
}
