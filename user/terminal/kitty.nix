{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enabled_layouts = "tall,*";
      window_padding_width = 5;
      font_family = "SpaceMono Nerd Font";
      font_size = 10;
      background_opacity = "0.90";
      tab_bar_style = "powerline";
      background = "#101010";
      foreground = "#cccccc";
      cursor = "#1bfd9c";
      selection_background = "#282828";
      selection_foreground = "#dddddd";
      color0 = "#2a2a2a";
      color1 = "#deeeed";
      color2 = "#1bfd9c";
      color3 = "#b4b4b4";
      color4 = "#7a7a7a"; 
      color5 = "#66b2b2";
      color6 = "#cccccc";
      color7 = "#f1f1f1";
      color8  = "#4a4a4a";
      color9  = "#708090";
      color10 = "#a6ffc9";
      color11 = "#dddddd";
      color12 = "#aaaaaa";
      color13 = "#49c4c4";
      color14 = "#d3d3d3";
      color15 = "#ffffff";
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+shift+t" = "launch --type=tab --cwd=current";
      "ctrl+shift+v" = "launch --location=vsplit --cwd=current";
      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+j" = "neighboring_window down";
      "ctrl+shift+k" = "neighboring_window up";
      "ctrl+shift+l" = "neighboring_window right";
    };
  };
}
