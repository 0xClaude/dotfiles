{ pkgs, ... }:

# This attribute set will be imported into your home-manager configuration
{
  programs.emacs = {
    
    extraPackages = ep: [
      ep.vterm # Terminal emulator inside Emacs
      ep.material-theme # A popular, clean theme
    ];

    # 3. Define the main configuration (init.el content)
    # This Lisp ensures a clean startup and sets the theme.
    preInit = ''
      ;; --- Basic UI Configuration ---
      (setq initial-scratch-message nil)     ; Clear the *scratch* buffer
      (setq inhibit-startup-message t)       ; Hide the splash screen

      ;; Use relative line numbers
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)

      ;; Show column numbers in the mode line
      (column-number-mode 1)

      ;; --- Theme Configuration ---
      (add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/elpa/"))
      (load-theme 'material t)
      (set-face-attribute 'default nil :font "Iosevka SS08" :height 100)
    '';
   # 4. Keybinding Example (Optional but useful)
    # This sets C-c C-v to open vterm (the embedded terminal)
    # This is an example of keybinding customization through Lisp.
    config = ''
      (global-set-key (kbd "C-c C-v") 'vterm)
    '';
  };
}