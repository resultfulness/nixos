{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cnijfilter2 ];

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

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
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
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

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    git
    alacritty
    neovim
    lua-language-server
    gcc
    stow
    rofi-wayland
    rofi-calc
    unstable.keepmenu
    keepassxc
    wl-clipboard
    hyprpicker
    hyprlock
    hyprshot
    brightnessctl
    playerctl
    nwg-look
    adwaita-icon-theme
    dunst
    pavucontrol
    unstable.signal-desktop
  ];

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

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "ComicShannsMono" ]; })
  ];

  environment.variables = {
    TERMINAL = "alacritty";
    BROWSER = "firefox";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.terminal-exec.enable = true;

  system.stateVersion = "24.11";
}
