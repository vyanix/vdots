{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      source ${pkgs.blesh}/share/blesh/ble.sh
    '';
    shellAliases = {
      ll = "eza -l --icons";
      la = "eza -a --icons";
      lt = "eza -T --icons";
    };
  };
}
