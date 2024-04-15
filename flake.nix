{
  description = "Custom self-contained developer environments powered by Nix-Flakes";

  outputs = { self, nixpkgs, ... }@inputs: {
    templates = {      
      langchain-rag = {
        path = ./templates/langchain-rag;
        description = "Template for a langchain retrieval augmented generation (RAG) project";
      };     

    };
  };
}