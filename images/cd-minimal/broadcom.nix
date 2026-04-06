# Some of my hardware requires broadcom drivers which are not included by default
{config, ...}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [config.boot.kernelPackages.broadcom_sta.name];
  boot.kernelModules = ["wl"];
  boot.extraModulePackages = [config.boot.kernelPackages.broadcom_sta];
}
