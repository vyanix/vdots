{ config, pkgs, ... }:

{
  imports = [
    ./modules/bootloader.nix
    ./modules/desktop.nix
    ./modules/networking.nix
    ./modules/packages.nix
    ./modules/settings.nix
    ./modules/user.nix
    ./modules/virtualisation.nix
  ];
}
