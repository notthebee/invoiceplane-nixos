{
  description = "A self-hosted open source application for managing your invoices, clients and payments.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      eachSystem = nixpkgs.lib.genAttrs systems;
    in
    {
      nixosModules = {
        invoiceplane = import ./modules/invoiceplane.nix { inherit self; };
        default = self.nixosModules.invoiceplane;
      };
      packages = eachSystem (system: {
        default = self.packages.${system}.invoiceplane;
        invoiceplane = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/invoiceplane.nix { };
      });
    };
}
