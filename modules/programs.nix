{ config, lib, pkgs, ... } :

{ 
    home.packages = with pkgs; [
        discord
        fzf
        joplin-desktop
        libreoffice
        mullvad-vpn
        nextcloud-client
        slack
        thunderbird
        ticktick
        veracrypt
        vorta
        vscode
    ];
}