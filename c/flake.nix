{
  description = "C Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
          buildInputs = [ pkgs.clang-tools pkgs.clang pkgs.gdb pkgs.valgrind ];
        };
      });
  };
}
