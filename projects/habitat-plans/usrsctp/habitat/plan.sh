pkg_name=usrsctp
pkg_origin=mozillareality
pkg_maintainer="Mozilla Mixed Reality <mixreality@mozilla.com>"

pkg_version="9.4.0"
pkg_source="https://github.com/gfodor/usrsctp/archive/0.9.4.0.tar.gz"
pkg_shasum="7077e275125ef98d33c8bf2d88d457a806b7c5e7811c1f614d60bbca0723f69c"
pkg_license=('BSD-3')
pkg_build_deps=(
  core/make
  core/gcc
  core/which
  core/libtool
  core/m4
  core/automake
  core/autoconf
)

pkg_lib_dirs=(lib)
pkg_include=(include)

do_build() {
  cd ../usrsctp-0.9.4.0
  ./bootstrap
  ./configure --prefix=${pkg_prefix}
  make
}

do_install() {
  cd ../usrsctp-0.9.4.0
  do_default_install
}
