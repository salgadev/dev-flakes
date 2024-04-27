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
          python-pkgs.pymongo
          python-pkgs.openai

          # build trulens from binary wheel
          python-pkgs.buildPythonPackage
          {
            pname = "trulens-eval";
            version = "0.28.1";
            format = "wheel";
            src = pkgs.fetchurl {
              url = "https://files.pythonhosted.org/packages/63/78/9f0c57ac92d462c74d5b90abb5ca43f175d9290eabad599f263744dec3e4/trulens_eval-0.28.1-py3-none-any.whl";
              sha256 = "0a51b9f62072b0cf90e370b81fe22d62e582fc87b83bc5706192b74e43689a29";
              };
          }
          
          # Build llama-index-vector-stores-mongodb from source
          python-pkgs.buildPythonPackage
          {
            name = "llama-index-vector-stores-mongodb";
            propagatedBuildInputs = [pkgs.python311.pkgs.setuptools];
            src = pkgs.fetchurl {
              url = "https://pypi.org/packages/source/l/llama-index-vector-stores-mongodb/llama-index-vector-stores-mongodb-0.1.4.tar.gz";
              sha256 = "b834a1787977c6b2731dca5ffbc5acffcf871a3709dc9b361322150550aaa823";
            };
          }

          # Build groq from source
          python-pkgs.buildPythonPackage
          {
            name = "groq";
            propagatedBuildInputs = [pkgs.python311.pkgs.setuptools];
            src = pkgs.fetchurl {
              url = "https://pypi.org/packages/source/g/groq/groq-0.5.0.tar.gz";
              sha256 = "d476cdc3383b45d2a4dc1876142a9542e663ea1029f9e07a05de24f895cae48c";
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
