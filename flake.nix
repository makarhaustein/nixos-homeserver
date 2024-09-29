{
  description = "A very basic flake";

  inputs = {
    nixpkgsunstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, nixpkgsunstable, ... } @ inputs: 
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pkgsus = nixpkgsunstable.legacyPackages.x86_64-linux;
    in
      {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	specialArgs = { inherit inputs; };
        modules= [
          ./configuration.nix
        ];
      };
    };
}
