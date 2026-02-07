{
  description = "Python AI/ML development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python312
            python312Packages.pip
            python312Packages.virtualenv
            
            # LSP and formatters
            pyright
            python312Packages.black
            python312Packages.isort
            ruff
          ];

          shellHook = ''
            echo "=== Python AI/ML Development ==="
            python --version
          '';
        };
      }
    );
}
