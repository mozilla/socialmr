pkg_name=libsrtp
pkg_origin=mozillareality
pkg_maintainer="Mozilla Mixed Reality <mixreality@mozilla.com>"

pkg_version="1.6.0"
pkg_source="https://github.com/cisco/libsrtp/archive/v1.6.0.zip"
pkg_shasum="475ec7693435b54d966efc888b1aeba17cf28cd698793aba7c253174c37a31b5"
pkg_build_deps=(core/make core/gcc core/openssl core/automake) 
pkg_description="This package provides an implementation of the Secure Real-time Transport Protocol (SRTP), the Universal Security Transform (UST), and a supporting cryptographic kernel."
pkg_upstream_url="https://github.com/cisco/libsrtp"

do_build() {
  cd ../libsrtp-${pkg_version}
  ./configure --prefix=${pkg_prefix} --enable-openssl 
  make clean
  make shared_library
}

do_install() {
  cd ../libsrtp-${pkg_version}
  do_default_install
}
