{
  description = "A Fullstack LLM app development flake powered by nd LangChain, Streamlit and Transformers";
  
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
          python-pkgs.pip # VsCode starts
          python-pkgs.jupyter
          python-pkgs.notebook # VsCode ends
          python-pkgs.pandas
          python-pkgs.requests
          python-pkgs.langchain-community
          python-pkgs.langchain
          python-pkgs.langchain-text-splitters
          python-pkgs.pypdf
          python-pkgs.openai
          python-pkgs.python-dotenv
          python-pkgs.configargparse
          python-pkgs.streamlit
          python-pkgs.sentence-transformers
        ]))
      ];

      shellHook = ''
        venv="$(cd $(dirname $(which python)); cd ..; pwd)"
        ln -Tsf "$venv" .venv
      '';
    };
  };
}
