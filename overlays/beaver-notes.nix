# overlays/beaver-notes.nix
{ pkgs, beaver-src, ... }:

let
  nodejs = pkgs.nodejs_20;      # Electron requires Node 20+
  yarn   = pkgs.yarn;
in

self: super: {

  beaver-notes = super.stdenv.mkDerivation {
    pname = "beaver-notes";
    version = "git";  # built from latest git

    src = beaver-src;

    nativeBuildInputs = [
      nodejs
      yarn
      pkgs.electron
      pkgs.makeWrapper
    ];

    # Allow Networking in build phase to fetch dependencies
    buildInputs = [];
    allowNetworking = true;

    buildPhase = ''
      echo "Installing dependencies..."
      yarn install --frozen-lockfile

      echo "Building Beaver Notes..."
      yarn run build
    '';

    installPhase = ''
      echo "Installing Beaver Notes..."

      mkdir -p $out/bin

      # Electron-builder usually outputs AppImage in dist/
      if [ -f dist/*.AppImage ]; then
        cp dist/*.AppImage $out/bin/beaver-notes
        chmod +x $out/bin/beaver-notes
      else
        echo "No AppImage found. Adjust installPhase if output is unpacked electron directory."
      fi
    '';

    meta = with pkgs.lib; {
      description = "Beaver Notes electron app, built from source";
      homepage = "https://github.com/Beaver-Notes/Beaver-Notes";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  };
}
