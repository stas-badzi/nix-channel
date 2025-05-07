let
  pkgs = import <nixpkgs> {};
in

{
  doas-keepenv = pkgs.callPackage ./pkgs/doas-keepenv {};
}