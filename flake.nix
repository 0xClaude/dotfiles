{
	description = "NixOS";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		silentSDDM = {
			url = "github:uiriansan/SilentSDDM";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, silentSDDM, ... }: {

		nixosConfigurations.nebula = nixpkgs.lib.nixosSystem {

			system = "x86_64-linux";

			specialArgs = {
				sources = import ./pins;

				inherit silentSDDM;
				unstablePkgs = import nixpkgs-unstable {
					system = "x86_64-linux";
					config.allowUnfree = true;
				};
			};

			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					nixpkgs.config.allowUnfree = true;

					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.claude = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	};
}
