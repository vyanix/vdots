{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-b0966ec1-8037-4b7f-b8ec-092bbf698747".device = "/dev/disk/by-uuid/b0966ec1-8037-4b7f-b8ec-092bbf698747";
  boot.blacklistedKernelModules = [ "btusb" ];

  # Networking.
  networking.hostName = "my-nixos";
  # networking.wireless.enable = false;
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = false;

  # Time zone.
  time.timeZone = "Asia/Kolkata";

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Desktop.
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    displayManager.startx.enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./user/config/dwm;
      };
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  services.pulseaudio.enable = false;
  hardware.alsa.enablePersistence = true;
  services.pipewire.enable = false;
  security.rtkit.enable = false;
  fonts.packages = with pkgs; [
    nerd-fonts.space-mono
  ];

  # User.
  users.users.vyanix = {
    isNormalUser = true;
    description = "vyanix";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
  };

  # Nix.
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };
  nixpkgs.config.allowUnfree = true;
  
  # Power.
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Packages.
  environment.systemPackages = with pkgs; [
    alsa-utils
    blesh
    brightnessctl
    curl
    git
    lm_sensors
    tlp
    vim
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.dconf.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";

}
