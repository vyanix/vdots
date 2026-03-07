{ config, pkgs, ... }:

{
  imports = [
    ./user/shell/bash.nix
    ./user/shell/starship.nix
    ./user/terminal/kitty.nix
    ./user/terminal/fastfetch.nix
    ./user/suckless/suckless.nix
    ./user/compositor/picom.nix
  ];
  home.username = "vyanix";
  home.homeDirectory = "/home/vyanix";
  home.stateVersion = "25.11";
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "vyanix";
        email = "186918137+vyanix@users.noreply.github.com";
      };
      init.defaultBranch = "main";
    };
  };
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  gtk = {
    enable = true;
    font = {
      name = "SpaceMono Nerd Font";
      size = 10;
    };
  };
  home.packages = with pkgs; [
    aria2
    bat
    bash-language-server
    brave
    btop
    eza
    fd
    flameshot
    fzf
    lua-language-server
    luajitPackages.luacheck
    ncdu
    nixd
    nixfmt
    pavucontrol
    qalculate-gtk
    ripgrep
    shfmt
    stylua
    tree-sitter
    unzip
    xclip
    xwallpaper
    yazi
  ];
}
