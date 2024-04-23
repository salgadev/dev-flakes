{
  description = "A Fullstack LLM app development flake powered by tool set Llama-Index, MongoDB and GPT-4";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    #       ↑ Swap it for your system if needed
    #       "aarch64-linux" / "x86_64-darwin" / "aarch64-darwin"
    debug = true;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        (pkgs.python311.withPackages (python-pkgs: [          
          # enable Jupyter with VsCode 
          python-pkgs.pip 
          python-pkgs.jupyter
          python-pkgs.notebook

          # often required libraries
          python-pkgs.pandas
          python-pkgs.requests          
          python-pkgs.python-dotenv
          python-pkgs.configargparse

          # RAG Tech stack
          python-pkgs.llama-index-core
          python-pkgs.openai
          python-pkgs.pymongo          

          # Build llama-index-vector-stores-mongodb from source
          python-pkgs.buildPythonPackage {
            name = "llama-index-vector-stores-mongodb";
            propagatedBuildInputs = [ pkgs.python311.pkgs.setuptools ];
            src = pkgs.fetchurl {
              url = "https://pypi.org/packages/source/l/llama-index-vector-stores-mongodb/llama-index-vector-stores-mongodb-0.1.4.tar.gz";
              sha256 = "b834a1787977c6b2731dca5ffbc5acffcf871a3709dc9b361322150550aaa823"; 
              };
            }
          ]))
        ];

    shellHook = ''
      venv="$(cd $(dirname $(which python)); cd ..; pwd)"
      ln -Tsf "$venv" .venv
    '';
    };
  };
}