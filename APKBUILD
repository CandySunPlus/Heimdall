pkgname=heimdall
pkgver=1.0.0
pkgrel=0
url="https://github.com/CandySunPlus/Heimdall?organization=CandySunPlus&organization=CandySunPlus"
pkgdesc="Heimdall is a cross-platform open-source tool suite used to flash firmware (aka ROMs) onto Samsung Galaxy devices."
arch="all"
license="MIT"
depends="eudev"
makedepends="libusb-dev"
checkdepends=""
install=""
source="
./heimdall/60-heimdall.rules
"
subpackages=""
builddir="$srcdir/"
options="!strip"

build() {
    cmake -B build ../ -DDISABLE_FRONTEND=ON
    cmake --build ./build
}

check() {
    $srcdir/build/bin/heimdall --help
}

package() {
    install -m751 -D "$srcdir/build/bin/heimdall" "$pkgdir/usr/bin/heimdall"
    install -m644 -D "$srcdir/60-heimdall.rules" "$pkgdir/etc/udev/rules.d/60-heimdall.rules"
}

sha512sums="
3f48393031a5f095ae5f65845a04afcbdd35b41455112f84113ad48dc6f5889fd5d67de5bb1a955fbb784fb28a1b42bfbb5f184d753f5a6a19ecda609161cf44  60-heimdall.rules
"
