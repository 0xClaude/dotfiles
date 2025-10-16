{ config, lib, pkgs, ... } :

{ 
  home.packages = with pkgs; [
    discord
    fzf
    joplin-desktop
    libreoffice
    mullvad-vpn
    nextcloud-client
    qalculate-qt
    slack
    thunderbird
    ticktick
    veracrypt
    vorta
    vscode
  ];
}