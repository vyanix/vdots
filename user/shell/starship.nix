{ pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = false;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = true;

      # Primary Format String
      format = lib.concatStrings [
	"╭"
        "$os"
        "$cmd_duration"
        "$battery"
        "$character"
        "$status"
        "$sudo"
        "$env_var"
        "$username"
        "$hostname"
        "$localip"
        "$directory"
        "$git_branch"
        "$git_status"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$fossil_branch"
        "$fossil_metrics"
        "$hg_branch"
        "$pijul_channel"
        "$vcsh"
        "$buf"
        "$bun"
        "$c"
        "$cmake"
        "$cobol"
        "$conda"
        "$crystal"
        "$daml"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$fortran"
        "$gleam"
        "$golang"
        "$gradle"
        "$haxe"
        "$helm"
        "$haskell"
        "$java"
        "$julia"
        "$kotlin"
        "$lua"
        "$meson"
        "$mise"
        "$mojo"
        "$nats"
        "$nim"
        "$nix_shell"
        "$nodejs"
        "$ocaml"
        "$odin"
        "$opa"
        "$package"
        "$perl"
        "$php"
        "$pulumi"
        "$purescript"
        "$python"
        "$quarto"
        "$raku"
        "$red"
        "$rlang"
        "$ruby"
        "$scala"
        "$rust"
        "$spack"
        "$swift"
        "$terraform"
        "$typst"
        "$vagrant"
        "$vlang"
        "$xmake"
        "$zig"
        "$aws"
        "$azure"
        "$docker_context"
        "$gcloud"
        "$guix_shell"
        "$kubernetes"
        "$openstack"
        "$pixi"
        "$singularity"
        "$time"
        "$shlvl"
        "$jobs"
        "$shell"
	"$line_break"
	"╰> "
      ];

      # Palettes
      palette = "dark";
      palettes.light = {
        success_fg = "green";
        error_fg = "red";
        fg_1 = "black";
        bg_1 = "white";
      };
      palettes.dark = {
        success_fg = "green";
        error_fg = "red";
        fg_1 = "brightwhite";
        bg_1 = "darkblack";
      };

      line_break.disabled = false;

      os = {
        disabled = false;
        style = "fg:fg_1 bg:bg_1";
        format = "[ $symbol ]($style)";
        symbols = {
          Alpine = " ";
          Arch = " ";
          Debian = " ";
          Fedora = " ";
          Gentoo = " ";
          Linux = " ";
          Macos = " ";
          NixOS = " ";
          Ubuntu = " ";
          Windows = " ";
          # Add others from your list as needed
        };
      };

      battery = {
        disabled = false;
        full_symbol = "󰂃 ";
        charging_symbol = "󰂉 ";
        discharging_symbol = "󰁽 ";
        empty_symbol = "󰂎 ";
        format = "[ $symbol$percentage ]($style)";
        display = [
          { threshold = 100; style = "fg:fg_1 bg:bg_1"; }
        ];
      };

      cmd_duration = {
        format = "[ $duration ]($style)";
        style = "fg:fg_1 bg:bg_1";
      };

      character = {
        success_symbol = "[](fg:success_fg bg:bg_1)";
        error_symbol = "[✘](fg:error_fg bg:bg_1)";
        format = "[ $symbol ](fg:fg_1 bg:bg_1)";
      };

      status = {
        disabled = false;
        format = "[$status:$common_meaning ](fg:error_fg bg:bg_1)";
      };

      sudo = {
        disabled = false;
        symbol = "🔑";
        style = "fg:fg_1 bg:bg_1";
        format = "[ $symbol ]($style)";
      };

      username = {
        show_always = true;
        style_user = "fg:fg_1 bg:bg_1";
        style_root = "fg:fg_1 bold bg:bg_1";
        format = "[  ($user) ]($style)";
      };

      directory = {
        style = "fg:fg_1 bg:bg_1";
        format = "[ $read_only$path ]($style)";
        read_only = "󰌾 ";
        truncation_length = 3;
        truncation_symbol = "…/";
        home_symbol = " ";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          ".config" = "";
          "Rust" = " ";
        };
      };

      git_branch = {
        symbol = "";
        style = "fg:fg_1 bg:bg_1";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "fg:fg_1 bg:bg_1";
        format = "[ $all_status$ahead_behind ]($style)";
        up_to_date = "✓";
      };

      # Toolchains (Simplified mapping - repeat for all languages)
      rust = { symbol = ""; style = "fg:fg_1 bg:bg_1"; format = "[ $symbol $version ]($style)"; };
      c = { symbol = " "; style = "fg:fg_1 bg:bg_1"; format = "[ $symbol $version ]($style)"; };
      lua = { symbol = " "; style = "fg:fg_1 bg:bg_1"; format = "[ $symbol $version ]($style)"; };
      nodejs = { symbol = "󰎙 "; style = "fg:fg_1 bg:bg_1"; format = "[ $symbol $version ]($style)"; };
      nix_shell = { symbol = " "; style = "fg:fg_1 bg:bg_1"; format = "[ $symbol $version ]($style)"; };

      time = {
        disabled = false;
        style = "fg:fg_1 bg:bg_1";
        format = "[  $time ]($style)";
      };

      shell = {
        disabled = false;
        zsh_indicator = "󰰶";
        bash_indicator = "";
        style = "fg:fg_1 bg:bg_1";
        format = "[ $indicator ]($style)";
      };
    };
  };
}
