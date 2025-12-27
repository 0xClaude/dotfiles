{ config, lib, pkgs, ... } :

{ 

  home.packages = with pkgs; [
    abiword
    anki-bin
    discord
    filezilla
    google-chrome
    joplin-desktop
    libreoffice
    mullvad-vpn
    nb
    nextcloud-client
    qbittorrent
    qownnotes
    slack
    thunderbird
    ticktick
    veracrypt
    vorta
    vscode
    zettlr
  ];
}