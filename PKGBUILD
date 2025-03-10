pkgname="asimov-cli"
pkgver="25.0.0-dev.2"
pkgrel=1
arch=('x86_64' 'aarch64')
url="https://github.com/asimov-platform/asimov-cli"
license=('MIT')

source_x86_64=("https://github.com/asimov-platform/asimov-cli/releases/download/${pkgver}/asimov-linux-x86.gz")
sha256sums_x86_64=("a64251f846d0cc0280a7f83f25f0db0c4f15ef4caf349ccd45dad22250866060")

source_aarch64=("https://github.com/asimov-platform/asimov-cli/releases/download/${pkgver}/asimov-linux-arm.gz")
sha256sums_aarch64=("e9ca2393fe6147a01f10a36bd162b8f014fcfc1e964bb65a33e6d0920b34960d")

package() {
    local filename="asimov-linux-$(uname -m).gz"
    gunzip -c "$srcdir/$filename" > "$pkgdir/usr/bin/asimov"
    chmod +x "$pkgdir/usr/bin/asimov"
}
