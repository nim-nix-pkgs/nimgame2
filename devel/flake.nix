{
  description = ''A simple 2D game engine for Nim language.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimgame2-devel.flake = false;
  inputs.src-nimgame2-devel.ref   = "refs/heads/devel";
  inputs.src-nimgame2-devel.owner = "Vladar4";
  inputs.src-nimgame2-devel.repo  = "nimgame2";
  inputs.src-nimgame2-devel.type  = "github";
  
  inputs."sdl2_nim".owner = "nim-nix-pkgs";
  inputs."sdl2_nim".ref   = "master";
  inputs."sdl2_nim".repo  = "sdl2_nim";
  inputs."sdl2_nim".dir   = "v2_0_14_3";
  inputs."sdl2_nim".type  = "github";
  inputs."sdl2_nim".inputs.nixpkgs.follows = "nixpkgs";
  inputs."sdl2_nim".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimgame2-devel"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimgame2-devel";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}