{
  description = "Repository for my packages.";

  inputs.nixpkgs.url = "github:nixoS/nixpkgs/nixpkgs-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
  in {
    images = import ./images {inherit nixpkgs;};

    legacyPackages = forAllSystems (
      system:
        import ./pkgs {
          pkgs = import nixpkgs {inherit system;};
        }
    );

    packages = forAllSystems (
      system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
    );

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
