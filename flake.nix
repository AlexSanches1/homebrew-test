{
  description = "Asimov CLI Tool (Nix-based), replicating Brew platform logic";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  # ^ Choose the channel you prefer (e.g., nixos-unstable).

  outputs = { self, nixpkgs, ... }:
    let
      # Example: "x86_64-linux", "aarch64-linux", "x86_64-darwin", "aarch64-darwin"
      system = builtins.currentSystem;
      pkgs = import nixpkgs { inherit system; };

      # We'll detect Darwin vs. Linux, and Intel vs. ARM, just like your Brew formula.
      isDarwin = pkgs.stdenv.isDarwin;
      isAarch64 = pkgs.stdenv.hostPlatform.system == "aarch64-darwin"
               || pkgs.stdenv.hostPlatform.system == "aarch64-linux";

      version = "25.0.0-dev.2";

      # Use the same URL and sha256 combos from your Brew formula:
      # macOS (Intel/ARM) & Linux (Intel/ARM).
      getUrlAndSha =
        if isDarwin then
          if isAarch64 then {
            # macOS ARM
            url = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-macos-arm.gz";
            sha256 = "af05128473c3dfda48e7740d2a456a7996a6391ac46a3ef0620cb803afaeb793";
          } else {
            # macOS Intel
            url = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-macos-x86.gz";
            sha256 = "332f2a586bb3d702db60b165f09b96a01995034a35ab109713d01ba53f0cb2cf";
          }
        else
          if isAarch64 then {
            # Linux ARM
            url = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-linux-arm.gz";
            sha256 = "e9ca2393fe6147a01f10a36bd162b8f014fcfc1e964bb65a33e6d0920b34960d";
          } else {
            # Linux Intel
            url = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-linux-x86.gz";
            sha256 = "a64251f846d0cc0280a7f83f25f0db0c4f15ef4caf349ccd45dad22250866060";
          };
    in
    {
      packages."${system}".default = pkgs.stdenv.mkDerivation {
        pname = "asimov-cli";
        inherit version;

        # Fetch the matching .gz file from your GitHub Releases
        src = pkgs.fetchurl {
          url = getUrlAndSha.url;
          sha256 = getUrlAndSha.sha256;
        };

        nativeBuildInputs = [ pkgs.gnugzip ];
        phases = [ "unpackPhase" "installPhase" ];

        unpackPhase = ''
          cp $src asimov.gz
          gunzip asimov.gz
          chmod +x asimov
        '';

        installPhase = ''
          mkdir -p $out/bin
          mv asimov $out/bin/
        '';

        # Optional build-time check (like `brew test do`):
        checkPhase = ''
          $out/bin/asimov --version
        '';
        doCheck = true;
      };
    };
}
