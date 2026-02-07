{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.dmenu.overrideAttrs (_: {
      src = ../config/dmenu;
      patches = [];
    }))
    (pkgs.slstatus.overrideAttrs (_: {
      src = ../config/slstatus;
      patches = [];
    }))
  ];
}
