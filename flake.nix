{
	description = "NixOS";

	inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		silentSDDM = {
			url = "github:uiriansan/SilentSDDM";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# DMS
		dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };

		niri = {
  		url = "github:sodiboo/niri-flake";
  		inputs.nixpkgs.follows = "nixpkgs";
		};
		
		vicinae = {
			url = "github:vicinaehq/vicinae";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = inputs @ { 
		self, 
		nixpkgs, 
		home-manager, 
		... 
	}: 
	let system = "x86_64-linux"; in
		{

		nixosConfigurations.nebula = nixpkgs.lib.nixosSystem {

			system = system;

			specialArgs = {
				inherit inputs;
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
						};

						users.claude = import ./home.nix;
						backupFileExtension = "backup";

					};
				}
			];
		};
	};
}
