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
            python311
            python311Packages.pip
            python311Packages.virtualenv
            
            # LSP and formatters
            python311Packages.python-lsp-server
            python311Packages.black
            python311Packages.isort
            python311Packages.pylint
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
