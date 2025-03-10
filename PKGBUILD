package() {
    local filename="asimov-linux-$(uname -m).gz"
    local extracted_file="${filename%.gz}"  # Remove .gz suffix

    # Ensure we are in the correct source directory
    cd "$srcdir" || exit 1

    # Debugging: List files in $srcdir again
    echo "DEBUG: Listing contents of $srcdir"
    ls -lah "$srcdir"

    # Check if the original gzipped file exists
    if [[ ! -f "$filename" && ! -L "$filename" ]]; then
        echo "ERROR: $filename not found in $srcdir!"
        exit 1
    fi

    # Follow symbolic link if necessary
    if [[ -L "$filename" ]]; then
        real_filename=$(readlink -f "$filename")
        echo "Following symlink: $filename -> $real_filename"
        filename="$real_filename"
    fi

    # Extract the binary
    gunzip -c "$filename" > "$srcdir/$extracted_file"

    # Ensure it's executable
    chmod +x "$srcdir/$extracted_file"

    # Move to the correct install directory
    install -Dm755 "$srcdir/$extracted_file" "$pkgdir/usr/bin/asimov"
}
