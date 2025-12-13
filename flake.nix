{
	description = "NixOS";

	inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs-unstable";
		};

		silentSDDM = {
			url = "github:uiriansan/SilentSDDM";
			inputs.nixpkgs.follows = "nixpkgs-unstable";
		};

		# DMS
		dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.dgop.follows = "dgop";
    };

		niri = {
  		url = "github:sodiboo/niri-flake";
  		inputs.nixpkgs.follows = "nixpkgs-unstable";
		};

	};

	outputs = inputs @ { 
		self, 
		nixpkgs, 
		nixpkgs-unstable, 
		home-manager, 
		silentSDDM, 
		dankMaterialShell, 
		niri, 
		... 
	}: 
	let system = "x86_64-linux"; in
		{

		nixosConfigurations.nebula = nixpkgs.lib.nixosSystem {

			system = system;

			specialArgs = {
				inherit silentSDDM;
				unstablePkgs = import nixpkgs-unstable {
					system = system;
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

						extraSpecialArgs = {
							inherit inputs;
							pkgsUnstable = import nixpkgs-unstable {
								system = system;
								config.allowUnfree = true;
							};
						};

						users.claude = import ./home.nix;
						backupFileExtension = "backup";

					};
				}
			];
		};
	};
}
