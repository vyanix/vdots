{
  description = "Systems development environment";

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
          packages = with pkgs; [
            gcc
            gdb
            gnumake

            llvmPackages.clang
            llvmPackages.bintools
            llvmPackages.openmp

            cmake
            ninja

            pkg-config
	    gettext
            ccache
	    ncurses
            xorg.libX11

            valgrind
            clang-tools

            lua5_1
            luajitPackages.luarocks

            rustc
            cargo
            rustfmt
            clippy
            rust-analyzer
            lld
          ];

          shellHook = ''
            echo "=== Systems Lab (GNU + LLVM + Lua + Rust) ==="
            echo "   GCC:   $(gcc --version | head -n1)"
            echo "   Clang: $(clang --version | head -n1)"
            echo "   Lua:   $(lua -v 2>&1 | head -n1)"
            echo "   Rust:  $(rustc --version)"
            export CPATH="${pkgs.glibc.dev}/include:${pkgs.gcc.cc}/include"
            export CPLUS_INCLUDE_PATH="${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}:${pkgs.glibc.dev}/include"
            export LIBRARY_PATH="${pkgs.glibc}/lib:${pkgs.gcc.cc}/lib"
          '';
        };
      }
    );
}
