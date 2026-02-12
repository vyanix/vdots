{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enabled_layouts = "tall,*";
      window_padding_width = 2;

      font_family = "GohuFont Nerd Font";
      font_size = 11;
      disable_ligatures = "always";
      
      background_opacity = "1.0";
      
      tab_bar_style = "separator";
      tab_separator = " | ";
      
      background = "#ffffea";
      foreground = "#000000";
      cursor = "#000000";
      cursor_text_color = "#ffffea";
      
      selection_background = "#eaffff";
      selection_foreground = "#000000";
      
      color0 = "#000000";  
      color1 = "#aa0000";  
      color2 = "#00aa00";  
      color3 = "#aa5500";  
      color4 = "#0000aa";  
      color5 = "#aa00aa";  
      color6 = "#00aaaa";  
      color7 = "#cccccc";  
      
      color8  = "#444444";  
      color9  = "#ff4444";  
      color10 = "#44ff44";  
      color11 = "#ffaa00";  
      color12 = "#4444ff";  
      color13 = "#ff44ff";  
      color14 = "#44ffff";  
      color15 = "#ffffff"; 
      
      active_tab_foreground = "#000000";
      active_tab_background = "#eaffff";
      inactive_tab_foreground = "#666666";
      inactive_tab_background = "#ffffea";
      
      active_border_color = "#000000";
      inactive_border_color = "#999999";
      
      enable_audio_bell = false;
      visual_bell_duration = "0.0";
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
