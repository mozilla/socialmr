pkg_name=janus
pkg_origin=mozillareality
pkg_maintainer="Mozilla Mixed Reality <mixreality@mozilla.com>"

pkg_version="0.2.4"
pkg_license=('GPLv3')
pkg_source="https://github.com/meetecho/janus-gateway/archive/v0.2.4.tar.gz"
pkg_description="Janus is an open source, general purpose, WebRTC gateway"
pkg_upstream_url="https://janus.conf.meetecho.com/"
pkg_exposes=(webrtc-port sctp-transport-socket)
pkg_build_deps=(
  core/make
  core/gcc
  core/pkg-config
)

pkg_deps=(
  core/openssl
  core/glib
  mozillareality/jansson
  mozillareality/libnice
  mozillareality/libsrtp
  mozillareality/usrsctp
  mozillareality/libmicrohttpd
  mozillareality/libwebsockets
  mozillareality/opus
  mozillareality/gengetopt
)
