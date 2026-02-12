{ config, pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "xrender";
    vsync = false;

    extraConfig = ''
      use-damage = true;

      shadow = true;
      shadow-radius = 6;
      shadow-offset-x = 0;
      shadow-offset-y = 3;
      shadow-opacity = 0.85;

      shadow-exclude = [
        "window_type = 'desktop'",
        "_GTK_FRAME_EXTENTS@:c"
      ];

      corner-radius = 0;
      detect-rounded-corners = false;

      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
    '';
  };
}
