{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    tlp
    lm_sensors
    blesh
    brightnessctl
  ];
}
