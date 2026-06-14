{
  description = "luo.sh — personal site built with bowen (Zola fork) and the carbon theme";

  # Flake inputs
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
    bowen = {
      url = "github:chessl/bowen/main";
      flake = false; # we don't need bowen's flake outputs, just its source
    };
  };

  # Flake outputs
  outputs =
    {
      self,
      nixpkgs,
      bowen,
    }:
    let
      # The systems supported for this flake
      supportedSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forEachSupportedSystem =
        f: nixpkgs.lib.genAttrs supportedSystems (system: f { pkgs = import nixpkgs { inherit system; }; });

      # Build `bowen` from the chessl/bowen source pinned above, with Chinese full-text search
      # indexing explicitly enabled. This mirrors what `cargo build --features indexing-zh` does
      # in the bowen repo, but pinning everything through nix so we don't have to manage a Rust
      # toolchain locally.
      #
      # Why declare `indexing-zh` at all? It's already in bowen's `default` features upstream,
      # but listing it explicitly keeps this working even if upstream ever narrows the default.
      mkBowenWithIndexing =
        { pkgs }:
        let
          rustPlatform = pkgs.rustPlatform;
        in
        rustPlatform.buildRustPackage {
          pname = "bowen";
          version = "0.1.0";

          src = bowen;

          # `cargoHash` is a placeholder. Set `cargoHash = "";` and run the build once — the
          # failure message contains the real hash you should paste in. Once you do, nix will
          # be able to use the cached prebuilt bowen for everyone else and skip the long local
          # compile.
          cargoHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

          # Lock bowen down to a specific Cargo.lock so vendor hash validation is reproducible.
          cargoLock = {
            lockFile = "${bowen}/Cargo.lock";
            allowBuiltinFetchGit = true;
          };

          # We only ship the `bowen` binary, mirroring the upstream flake.
          cargoBuildFlags = [
            "--bin"
            "bowen"
            "--features"
            "indexing-zh"
          ];

          # Build-time deps: oniguruma (regex tokenizer), openssl (rustls), and on darwin
          # libiconv + apple-sdk (matches bowen's upstream nix flake).
          nativeBuildInputs = with pkgs; [ pkg-config ];

          buildInputs =
            with pkgs;
            [
              oniguruma
              openssl
            ]
            ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
              pkgs.libiconv
              pkgs.apple-sdk
            ];

          # RUSTONIG_SYSTEM_LIBONIG lets bowen link against the oniguruma we provide above
          # instead of compiling a vendored copy. Drastically shortens the build.
          env.RUSTONIG_SYSTEM_LIBONIG = true;

          # Tests are slow and network-dependent; skip them.
          doCheck = false;

          meta = {
            description = "A fork of Zola adding Typst math + D2 diagrams (with zh indexing).";
            mainProgram = "bowen";
          };
        };
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }: {
          default = pkgs.mkShell {
            # The Nix packages provided in the environment
            packages = [
              # Foreground so `bowen` (and the carbon theme it serves) is built locally with
              # Chinese search indexing baked in.
              (mkBowenWithIndexing { inherit pkgs; })
            ];

            # Set any environment variables for your dev shell
            env = { };

            # Add any shell logic you want executed any time the environment is activated
            shellHook = "";
          };
        }
      );
    };
}
