{
  description = "Systems development environments";

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
        devShells = {
          # GCC-based GNU toolchain
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              gcc
              gdb
              gnumake
              cmake
              nasm
              valgrind
              binutils
              
              clang-tools  # for clangd LSP
              asm-lsp
              cmake-language-server
              
              bear
              cppcheck
              glibc.dev
            ];

            shellHook = ''
              echo "=== GCC GNU Toolchain ==="
              echo "GCC: $(gcc --version | head -n1)"
              echo "GDB: $(gdb --version | head -n1)"
              echo "clangd available for LSP"
            '';
          };

          # LLVM/Clang toolchain
          llvm = pkgs.mkShell {
            buildInputs = with pkgs; [
              clang
              llvm
              lld
              lldb
              cmake
              ninja
              nasm
              yasm
              
              clang-tools  # clangd, clang-format, clang-tidy
              asm-lsp
              cmake-language-server
              
              # Static analysis
              cppcheck
              valgrind
              bear
            ];

            shellHook = ''
              echo "=== LLVM/Clang Toolchain ==="
              echo "Clang: $(clang --version | head -n1)"
              export CC=clang
              export CXX=clang++
              export LD=lld
              echo "Environment configured for LLVM toolchain"
            '';
          };

          # Cross-compilation & Embedded
          cross = pkgs.mkShell {
            buildInputs = with pkgs; [
              gcc
              clang
              gdb
              lldb
              cmake
              gnumake
              nasm
              
              # Cross-compilation & emulation
              qemu
              qemu_kvm
              
              # Binary analysis
              binutils
              elfutils
              patchelf
              
              # Debugging & tracing
              strace
              ltrace
              valgrind
              
              clang-tools
              asm-lsp
              cmake-language-server
              
              bear
              xxd
              hexdump
            ];

            shellHook = ''
              echo "=== Cross-compilation & Embedded ==="
              echo "GCC: $(gcc --version | head -n1)"
              echo "QEMU available at: ${pkgs.qemu}/bin"
              echo "Ready for bare-metal and cross-platform development"
              export QEMU_SYSTEM=${pkgs.qemu}/bin
            '';
          };
        };
      }
    );
}
