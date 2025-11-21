{ config, lib, pkgs, ... } :

{ 

  home.packages = with pkgs; [
    abiword
    anki-bin
    beaver-notes
    discord
    filezilla
    google-chrome
    joplin-desktop
    libreoffice
    mullvad-vpn
    nextcloud-client
    qbittorrent
    slack
    thunderbird
    ticktick
    veracrypt
    vorta
    vscode
  ];
}