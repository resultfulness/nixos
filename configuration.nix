{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "orka";
  networking.networkmanager.enable = true; 
  networking.firewall.enable = false;
  services.openssh.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.graphics.enable = true;
  hardware.nvidia = {
    nvidiaSettings = true;
    open = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.awesome.enable = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput = { 
    enable = true;
    mouse.accelProfile = "flat";
    mouse.accelSpeed = "0.0";
    touchpad.naturalScrolling = true;
  };
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        config = ''
(defsrc
    caps
)

(deflayer base
    lctrl
)
        '';
      };
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      stow
      rofi-wayland
      rofi-calc
      unstable.keepmenu
      keepassxc
      dunst
      unstable.signal-desktop
      unstable.prismlauncher
      pavucontrol
      hyprpicker
      hyprlock
      hyprshot
      brightnessctl
      playerctl
      qbittorrent
    ];
  };

  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  programs.tmux.enable = true;
  programs.starship.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-volman
  ];
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.xfconf.enable = true;
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "ComicShannsMono" ]; })
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    gcc
    neovim
    lua-language-server
    wget
    git
    nwg-look
    adwaita-icon-theme
    wl-clipboard
  ];

  environment.variables = {
    TERMINAL = "alacritty";
    BROWSER = "firefox";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.terminal-exec.enable = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cnijfilter2 ];

  system.stateVersion = "24.11";
}

