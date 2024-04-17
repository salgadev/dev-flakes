# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    #       ↑ Swap it for your system if needed
    #       "aarch64-linux" / "x86_64-darwin" / "aarch64-darwin"
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        (pkgs.python311.withPackages (python-pkgs: [
          python-pkgs.numpy
          python-pkgs.pandas
          python-pkgs.scipy
          python-pkgs.matplotlib
          python-pkgs.requests
          python-pkgs.langchain-community
          python-pkgs.langchain-text-splitters
          python-pkgs.unstructured
          python-pkgs.unstructured-inference
          python-pkgs.tesseract
          python-pkgs.poppler
          python-pkgs.wrapt
          python-pkgs.openai
          python-pkgs.pydantic
          python-pkgs.python-dotenv
          python-pkgs.configargparse
          pkgs.unstructured-api
        ]))
      ];

      shellHook = ''
        venv="$(cd $(dirname $(which python)); cd ..; pwd)"
        ln -Tsf "$venv" .venv
      '';
    };
  };
}
