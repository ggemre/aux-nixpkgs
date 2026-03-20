{pkgs ? import <nixpkgs> {}}: {
  alejandra-spaced = pkgs.callPackage ./pkgs/alejandra-spaced {};
  ashell-mango = pkgs.callPackage ./pkgs/ashell-mango {};
  mangowm = pkgs.callPackage ./pkgs/mangowm {};
  tabler-icons = pkgs.callPackage ./pkgs/tabler-icons {};
}
