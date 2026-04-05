{nixpkgs ? import <nixpkgs>}: let
  mkImage = module: nixpkgs.lib.nixosSystem {modules = [module];};
in {
  cd-minimal = mkImage ./cd-minimal;
}
