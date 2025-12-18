{ config, pkgs, pkgsUnstable, inputs, ... }:
let
  dankMaterialShell = inputs.dankMaterialShell;
in
{
  home.username = "claude";
  home.homeDirectory = "/home/claude";
  home.stateVersion = "25.05";

  imports = [
    ./modules/system.nix
    ./modules/programs.nix
    ./modules/emacs.nix

    dankMaterialShell.homeModules.dankMaterialShell.default
    #vicinae.homeManagerModules.default
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Claude BIVER";
        email = "claude.biver@pm.me";
      };
      init.defaultBranch = "main";
    };
  };

  services.ssh-agent.enable = true;

  programs.vim.defaultEditor = true;

  programs.dankMaterialShell = {
    enable = true;
  };

  systemd.user.services.dms-shell = {
    Unit = {
      Description = "DMS Shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.dms-shell}/bin/dms-shell run -d";
      Restart = "always";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };


  home.packages = with pkgs; [
    # Add programs here
  ];

  home.file.".config/alacritty".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/alacritty";
    
  home.file.".config/niri".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/niri";

}
