pkgname="asimov-cli"
pkgver="25.0.0_dev2"  # Must be sanitized for makepkg
pkgrel=1
epoch=1  # Ensures compatibility with makepkg
arch=('x86_64' 'aarch64')
url="https://github.com/asimov-platform/asimov-cli"
license=('MIT')

_realver="25.0.0-dev.2"  # Original version used in download links

source_x86_64=("https://github.com/asimov-platform/asimov-cli/releases/download/${_realver}/asimov-linux-x86.gz")
sha256sums_x86_64=("a64251f846d0cc0280a7f83f25f0db0c4f15ef4caf349ccd45dad22250866060")

source_aarch64=("https://github.com/asimov-platform/asimov-cli/releases/download/${_realver}/asimov-linux-arm.gz")
sha256sums_aarch64=("e9ca2393fe6147a01f10a36bd162b8f014fcfc1e964bb65a33e6d0920b34960d")

package() {
    local filename="asimov-linux-$(uname -m).gz"
    local extracted_file="${filename%.gz}"  # Remove .gz suffix

    # Ensure we are in the correct source directory
    cd "$srcdir" || exit 1

    # Debugging: List files in the expected directory
    echo "DEBUG: Listing contents of $srcdir"
    ls -lah "$srcdir"

    # Check if file exists before extracting
    if [[ ! -f "$srcdir/$filename" ]]; then
        echo "ERROR: $filename not found in $srcdir!"
        exit 1
    fi

    # Extract the binary
    gunzip -c "$srcdir/$filename" > "$srcdir/$extracted_file"

    # Ensure it's executable
    chmod +x "$srcdir/$extracted_file"

    # Move to the correct install directory
    install -Dm755 "$srcdir/$extracted_file" "$pkgdir/usr/bin/asimov"
}


