{
  description = "Custom self-contained developer environments powered by Nix-Flakes";

  outputs = { self, nixpkgs, ... }@inputs: {
    templates = {      
      langchain-rag = {
        path = ./templates/langchain-rag;
        description = "Template for a langchain retrieval augmented generation (RAG) project";
      };     
      llama-rag = {
        path = ./templates/llama-rag;
        description = "Template for a retrieval augmented generation (RAG) project using LlamaIndex, PyMongo, OpenAI and TruEra's trulens";
      };    
    };
  };
}