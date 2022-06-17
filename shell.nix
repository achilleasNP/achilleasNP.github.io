{ pkgs ? import <nixpkgs> {} }:
 pkgs.mkShell {
  packages = [ pkgs.bundler ];

  shellHook = "bundle exec jekyll serve";
}
