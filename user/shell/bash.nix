{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
    };
    initExtra = ''
      if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
        eval "$(${pkgs.starship}/bin/starship init bash)"
      fi
      source ${pkgs.blesh}/share/blesh/ble.sh
    '';
    shellAliases = {
      ll = "eza -la --icons";
      lt = "eza -T --icons";
      y = "yazi";
    };
  };
}
