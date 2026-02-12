{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      nixd
      nixpkgs-fmt
    ];
    plugins = with pkgs.vimPlugins; [
      (pkgs.vimUtils.buildVimPlugin {
        name = "monoglow.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "wnkz";
          repo = "monoglow.nvim";
          rev = "main";
          hash = "sha256-V5yMUl2LO8GE094kJCFc5HG0LvpVEZjjlV2egcZJrg4=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "dookie.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "pebeto";
          repo = "dookie.nvim";
          rev = "main";
          hash = "sha256-+yr7A6fkOccZiRD/TCxzbiTZHbYyk0J/INPLAHSK2lc=";
        };
      })
      direnv-vim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      plenary-nvim
      lean-nvim
      (nvim-treesitter.withPlugins (p: [
        p.asm
        p.c
        p.cpp
        p.rust
        p.lua
        p.vim
        p.nix
        p.bash
        p.markdown
        p.haskell
        p.javascript
        p.typescript
        p.tsx
        p.toml
        p.json
      ]))
    ];
    extraLuaConfig = ''require('settings')'';
  };
  xdg.configFile."nvim/lua/settings.lua".source = ../../config/nvim/lua/settings.lua;
}
