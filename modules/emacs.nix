{ pkgs, ... }:

# This attribute set will be imported into your home-manager configuration
{
  programs.emacs = {
        
    extraPackages = ep: [
      ep.vterm            # Terminal emulator inside Emacs
      ep.magit            # Git porcelain
      ep.material-theme   # A popular, clean theme
    ];

    # 3. All Lisp configuration consolidated into 'extraConfig'.
    # This code runs after packages are installed and loaded.
    extraConfig = ''
      ;; --- Basic UI Configuration ---
      (setq initial-scratch-message nil)     ; Clear the *scratch* buffer
      (setq inhibit-startup-message t)       ; Hide the splash screen

      ;; Use relative line numbers
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)

      ;; Show column numbers in the mode line
      (column-number-mode 1)

      ;; --- Theme Configuration ---
      ;; Note: This path is often needed for themes to load correctly in HM setups
      (add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/elpa/"))
      (load-theme 'material t)
      (set-face-attribute 'default nil :font "Iosevka SS08" :height 100)

      ;; --- Keybindings (Relying on Packages) ---
      
      ;; Global keybinding for VTerm (embedded terminal)
      (global-set-key (kbd "C-c C-v") 'vterm)
      
      ;; Bind Magit-status to C-x g 
      (global-set-key (kbd "C-x g") 'magit-status)
    '';
  };
}