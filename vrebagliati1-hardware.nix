{ config, lib, pkgs, modulesPath, ... }:

{

  imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "uhci_hcd" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "compress=zstd:2" ];
    };

  swapDevices = [
      { device = "/dev/disk/by-label/swap"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
