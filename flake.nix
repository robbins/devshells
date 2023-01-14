{
  description = "Development environment devshell templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
  {
    templates = {
      "c" = {
        path = ./c;
        description = "C development environment";
      };
      "java" = {
        path = ./java;
        description = "Java development environment with JDT language server";
      };
    };
  };
}
