{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/sd-card/sd-image-aarch64-installer.nix")
  ];

  sdImage.compressImage = true;
  nixpkgs.hostPlatform = "aarch64-linux";
}
