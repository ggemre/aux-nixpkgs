{pkgs ? import <nixpkgs> {}}: {
  alejandra-spaced = pkgs.callPackage ./alejandra-spaced {};
  mangowm-wlonly = pkgs.callPackage ./mangowm-wlonly {};
}
