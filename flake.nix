{
  description = "starlight";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , pre-commit-hooks
    , flake-parts
    , ...
    } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; }
      {
        systems = [
          "x86_64-linux"
        ];
        perSystem =
          { config
          , pkgs
          , system
          , lib
          , ...
          }:
          let
           # TODO.
          in
          {
            # pre-commit.settings = {
            #   hooks = import ./pre-commit-hooks.nix { inherit pkgs; };
            # };
            packages = { };
            devShells.default = pkgs.mkShell {
              nativeBuildInputs = [
                pkgs.bun
                pkgs.nodePackages_latest.pnpm
              ];

              # shellHook = ''
              #   # Generate the .pre-commit-config.yaml symlink when entering the
              #   # development shell.
              #   ${config.pre-commit.installationScript}
              # '';
            };
          };
      };
}
