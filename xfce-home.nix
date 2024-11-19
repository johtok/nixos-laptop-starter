{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;
      iconTheme = {
      name = "elementary-Xfce-dark";
      package = pkgs.elementary-xfce-icon-theme;
    };
    theme = {
      name = "tokyonight";
      package = pkgs.tokyonight-gtk-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent.enable = true;
}

