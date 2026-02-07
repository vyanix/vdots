{ config, pkgs, ... }:

{
  networking.hostName = "my-nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = false;
} 
