# dev-flakes
Custom self-contained developer environments powered by Nix-Flakes

This repository **will** contain (WIP) a collection of Nix flake templates providing customized self-contained developer environments. 

# Available Templates
- `langchain-rag`: A Python 3.11 template for creating a LLM retrieval augmented generation (RAG) application using `unstructured` and `langchain`. 

# Usage
Initialize the desired template within your current flake or generate a new flake project in a new directory:

## Initializing an existing flake
Run the following command to initialize the langchain-rag template within your current flake:

```
nix flake init --template "github:salgadev/dev-flakes#langchain-rag"
```
## Creating a new flake project
Create a new directory for your project and navigate into it:

mkdir my_project && cd my_project
Then execute the following command to create a new flake project from the langchain-rag template:
```
nix flake new --template "github:salgadev/dev-flakes#langchain-rag" ."
```

# Customization
Modify any files inside the selected template directory (e.g., langchain-rag) to further customize the generated flake according to your preferences.

