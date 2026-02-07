{ config, lib, pkgs, ... }:

{
  imports =[
    ./hardware-configuration.nix
    ./system/bundle.nix
  ];

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "25.11";
}
