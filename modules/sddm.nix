{ config, pkgs, inputs, ... }:
let
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default"; # Customize: "rei", "ken", "silvia", "catppuccin-mocha", etc.
  };
in
{
  qt.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Keep Wayland support
    theme = sddm-theme.pname;
    extraPackages = sddm-theme.propagatedBuildInputs;
    settings = {
      General = {
        GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
        InputMethod = "qtvirtualkeyboard";
      };
    };
  };

  environment.systemPackages = [ sddm-theme sddm-theme.test ];
}
