{ pkgs ? import <nixpkgs> {} }:
rec {
  doas-keepenv = pkgs.callPackage ./pkgs/doas-keepenv {};
}