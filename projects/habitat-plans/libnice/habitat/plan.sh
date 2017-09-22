pkg_name=libnice
pkg_origin=mozillareality
pkg_maintainer="Mozilla Mixed Reality <mixreality@mozilla.com>"

pkg_version="0.1.14"
pkg_license=('MPL')
pkg_source="https://nice.freedesktop.org/releases/libnice-${pkg_version}.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="be120ba95d4490436f0da077ffa8f767bf727b82decf2bf499e39becc027809c"
pkg_build_deps=(core/make core/gcc core/pkg-config mozillareality/gnutls)
pkg_description="Libnice is an implementation of the IETF's Interactive Connectivity Establishment (ICE) standard (RFC 5245)"
pkg_upstream_url="https://nice.freedesktop.org/wiki/"
