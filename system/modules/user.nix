{ config, pkgs, ... }:

{
  users.users.vyanix = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
    shell = pkgs.bash;
  };
}
