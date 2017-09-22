pkg_name=janus-gateway
pkg_origin=mozillareality
pkg_maintainer="Mozilla Mixed Reality <mixreality@mozilla.com>"

pkg_version="0.2.4"
pkg_license=('GPLv3')
pkg_source="https://github.com/meetecho/janus-gateway/archive/v${pkg_version}.tar.gz"
pkg_shasum="b1064036dcdaae804e9e76e58fa7ec639cfdf09c716ece32b5a0a459b48c2ba7"
pkg_description="Janus is an open source, general purpose, WebRTC gateway"
pkg_upstream_url="https://janus.conf.meetecho.com/"
pkg_exposes=(webrtc-port sctp-transport-socket)
pkg_build_deps=(
  core/automake
  core/autoconf
  core/make
  core/gcc
  core/pkg-config
  core/which
  core/libtool
  core/m4
)

pkg_deps=(
  core/openssl
  core/glib
  mozillareality/jansson
  mozillareality/libsrtp
  mozillareality/usrsctp
  mozillareality/libmicrohttpd
  mozillareality/libwebsockets
  mozillareality/opus
  mozillareality/pcre
  #mozillareality/libnice
  #mozillareality/gengetopt
)

do_build() {
  libtoolize
  
  # This is a hack, but setting ACLOCAL flags etc didn't seem to work
  cp "$(pkg_path_for core/pkg-config)/share/aclocal/pkg.m4" "$(pkg_path_for core/automake)/share/aclocal/"

  sh autogen.sh
  sh configure --prefix="$pkg_prefix"
  make
}
