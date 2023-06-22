{
  description = "Print the currently-installed version of the specified npm package";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    forEachSystem = nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  in {
    packages = forEachSystem (system: {
      default = nixpkgs.legacyPackages.${system}.writeShellApplication {
        name = "npm-dep-version";
        runtimeInputs = with nixpkgs.legacyPackages.${system}; [nodejs-slim];
        text = builtins.readFile ./npm-dep-version.sh;
      };
    });
  };
}
