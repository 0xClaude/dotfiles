{ config, lib, pkgs, ... } :

{ 

  home.packages = with pkgs; [
    abiword
    discord
    fzf
    filezilla
    google-chrome
    joplin-desktop
    libreoffice
    mullvad-vpn
    nextcloud-client
    qalculate-qt
    qbittorrent
    slack
    speedtest-cli
    thunderbird
    tig
    ticktick
    veracrypt
    vorta
    vscode
  ];
}