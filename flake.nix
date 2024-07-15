{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        cross-pkgs = import nixpkgs {
          inherit system;
          crossSystem = {
            config = "aarch64-unknown-linux-gnu";
          };
        };
      in rec {
        packages = {};
        devShells = {
          cross-compiler = cross-pkgs.mkShell {
            buildInputs = [];
            hardeningDisable = [ "fortify" ];
            ARMGNU="aarch64-unknown-linux-gnu";
          };

          cross-qemu = pkgs.mkShell {
            buildInputs = [
              pkgs.qemu_full
            ];
          };
        };
      }
    );
}
