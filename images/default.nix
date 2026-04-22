{nixpkgs ? import <nixpkgs>}: let
  mkImage = module: nixpkgs.lib.nixosSystem {modules = [module];};
in {
  cd-installer = mkImage ./cd-installer;
  sd-image = mkImage ./sd-image;
}
