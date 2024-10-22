{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    ruby_3_2
    bundler
  ];

  shellHook = ''
    export GEM_HOME="$PWD/.gem"
    export PATH="$GEM_HOME/bin:$PATH"
    bundle config set --local path '.bundle'
    bundle install
  '';
}
