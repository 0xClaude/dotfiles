{ config, lib, pkgs, ... } :

{ 

  home.packages = with pkgs; [
    abiword
    anki-bin
    discord
    fzf
    filezilla
    google-chrome
    joplin-desktop
    libreoffice
    mpv
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