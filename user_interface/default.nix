{ pkgs, ... }:

{
  imports = [
  ./xfce.nix
  ./dwm.nix
  ./i3.nix
  ./dk.nix
  ];
}
