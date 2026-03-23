{pkgs ? import <nixpkgs> {}}: {
  alejandra-spaced = pkgs.callPackage ./pkgs/alejandra-spaced {};
  mangowm = pkgs.callPackage ./pkgs/mangowm {};
  mangowm-wlonly = pkgs.callPackage ./pkgs/mangowm-wlonly {};
}
