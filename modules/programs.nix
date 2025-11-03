{ config, lib, pkgs, ... } :

{ 

  home.packages = with pkgs; [
    discord
    fzf
    filezilla
    joplin-desktop
    libreoffice
    mullvad-vpn
    nextcloud-client
    qalculate-qt
    qbittorrent
    slack
    speedtest-cli
    thunderbird
    ticktick
    veracrypt
    vorta
    vscode
  ];
}