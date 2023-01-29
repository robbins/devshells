{
  description = "Java Development Environment with JDT language server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    language-servers = {
      url = "git+https://git.sr.ht/~bwolf/language-servers.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs }: let
    supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; } );
  in
  {
    devShells = forAllSystems (system:
      let pkgs = nixpkgsFor.${system};
      in {
        default = pkgs.mkShell {
          packages = [
            pkgs.jdk 
            language-servers.packages.${system}.jdt-language-server 
          ];
          shellHook = ''
            export JAVA_HOME=${pkgs.jdk.home}
          '';
        };
      });
  };
}
