package() {
    local filename="asimov-linux-$(uname -m).gz"
    local extracted_file="${filename%.gz}"  # Remove .gz suffix

    # Ensure we are in the correct source directory
    cd "$srcdir" || exit 1

    # Debugging: List files in $srcdir before extraction
    echo "DEBUG: Listing contents of $srcdir"
    ls -lah "$srcdir"

    # If the file is outside $srcdir, move it
    if [[ ! -f "$srcdir/$filename" && -f "../$filename" ]]; then
        echo "Moving $filename to $srcdir"
        mv "../$filename" "$srcdir/"
    fi

    # Check if file exists before extracting
    if [[ ! -f "$filename" ]]; then
        echo "ERROR: $filename not found in $srcdir!"
        exit 1
    fi

    # Extract the binary
    gunzip -c "$filename" > "$extracted_file"

    # Ensure it's executable
    chmod +x "$extracted_file"

    # Move to the correct install directory
    install -Dm755 "$extracted_file" "$pkgdir/usr/bin/asimov"
}
