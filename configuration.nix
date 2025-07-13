# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
      ./vrebagliati1-hardware.nix # Hardware specific
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/disk/by-id/ata-MB1000GCWCV_Z1W07YZ1";

  networking = {
    hostName = "vrebagliati1";
    useDHCP = lib.mkDefault true;
    interfaces.eno1.useDHCP = true;
    networkmanager.enable = true;
  };

  time.timeZone = "America/Argentina/Buenos_Aires";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keyFiles = [ "/home/admin/secrets/allowedKeys" ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.copySystemConfiguration = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = "https://channels.nixos.org/nixos-25.05-small";
  };

  system.stateVersion = "25.05"; # Do not change!

}
