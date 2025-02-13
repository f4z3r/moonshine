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
          luatext = buildLuarocksPackage {
            pname = "luatext";
            version = "1.2.0-0";
            knownRockspec =
              (pkgs.fetchurl {
                url = "mirror://luarocks/luatext-1.2.0-0.rockspec";
                sha256 = "1lmjhsnbpz4wkaypqaqas0rlahbhpsr0g9wgls6lsswh3dh5xx28";
              })
              .outPath;
            src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''              {
                "url": "https://github.com/f4z3r/luatext.git",
                "rev": "c8ada5144c7c23d44d37a10fa484fe91b34c11d0",
                "date": "2024-03-26T18:27:25+01:00",
                "path": "/nix/store/crga0pkvm25gwwns8n6jb9cakfkmjd90-luatext",
                "sha256": "0h6l7ws6baq5dxfs1ala8smm7pykh9vd13bxkh2a343hn834dx42",
                "hash": "sha256-gvRGBrJwkKEEnH2N0HaC099Tq0aKqqBdbwWrZTQ/1EA=",
                "fetchLFS": false,
                "fetchSubmodules": true,
                "deepClone": false,
                "leaveDotGit": false
              }
            '') ["date" "path" "sha256"]);

            disabled = luaOlder "5.1";
            propagatedBuildInputs = [lua];

            meta = {
              homepage = "https://github.com/f4z3r/luatext/tree/main";
              description = "A small library to print colored text";
              license.fullName = "MIT";
            };
          };
        in [lanes luatext];
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
