{
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ./broadcom.nix
  ];

  networking.networkmanager.enable = true;
  nixpkgs.hostPlatform = "x86_64-linux";
}
