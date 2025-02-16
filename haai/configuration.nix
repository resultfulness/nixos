{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  networking.hostName = "haai";

  environment.systemPackages = with pkgs; [
  ];
}

