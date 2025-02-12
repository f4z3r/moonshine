{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = import nixpkgs {inherit system;};
      luaPackages = {
        lua54 = pkgs.lua54Packages;
        lua53 = pkgs.lua53Packages;
        lua52 = pkgs.lua52Packages;
        lua51 = pkgs.lua51Packages;
        luajit = pkgs.luajitPackages;
        default = pkgs.luajitPackages;
      };
      custom-lua-packages = luaPkgs:
        with luaPkgs; let
          lanes = buildLuarocksPackage {
            pname = "lanes";
            version = "3.16.0-0";
            knownRockspec =
              (pkgs.fetchurl {
                url = "mirror://luarocks/lanes-3.16.0-0.rockspec";
                sha256 = "0clnd3fsbx6w340bqddkcw0kdp4jsnnymf0mwcxdh0njkqfsxwma";
              })
              .outPath;
            src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''
              {
                "url": "https://github.com/LuaLanes/lanes.git",
                "rev": "49ef9d50d475921aab0c50b13b857f8cb990fcc0",
                "date": "2022-03-09T14:11:21+01:00",
                "path": "/nix/store/b35avrsmhz6qpz7ypy4z323x4mzi4nzv-lanes",
                "sha256": "1i3py8h1m9va4fha5j5awzpfrg830rsda1691kbmj7k15i8xi2z1",
                "fetchLFS": false,
                "fetchSubmodules": true,
                "deepClone": false,
                "leaveDotGit": false
              }
            '') ["date" "path"]);

            disabled = luaOlder "5.1";
            propagatedBuildInputs = [lua];
            externalDeps = [
              {
                name = "PTHREAD";
                dep = pkgs.glibc;
              }
            ];

            meta = {
              homepage = "https://github.com/LuaLanes/lanes";
              description = "Multithreading support for Lua";
              license.fullName = "MIT/X11";
            };
          };
        in [lanes];
      makeLuaShell = shellName: luaPackage:
        pkgs.mkShell {
          packages = with pkgs;
            [
              selene
              stylua
            ]
            ++ (with luaPackage;
              [busted luaposix]
              ++ (custom-lua-packages luaPackage));
          shellHook = ''
            export LUA_PATH="./?.lua;./?/init.lua;$LUA_PATH"
            exec fish
          '';
        };
    in {
      devShells = builtins.mapAttrs makeLuaShell luaPackages;
    });
}
