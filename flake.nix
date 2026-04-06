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
    legacyPackages = forAllSystems (
      system:
        import ./default.nix {
          pkgs = import nixpkgs {inherit system;};
        }
    );

    packages = forAllSystems (
      system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
    );

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    checks = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
        allChecks = import ./default.nix {
          inherit pkgs;
        };
      in
        pkgs.lib.filterAttrs (
          _name: drv:
            !(drv.meta.broken or false)
        )
        allChecks
    );
  };
}
