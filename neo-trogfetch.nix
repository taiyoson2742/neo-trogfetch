# Build/run with:
#   nix-build neo-trogfetch.nix && ./result/bin/neo-trogfetch
#   nix-shell -p '(import ./neo-trogfetch.nix {})' --run neo-trogfetch
# or in configuration.nix / home-manager:
#   environment.systemPackages = [ (pkgs.callPackage ./neo-trogfetch.nix {}) ];
{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
  name = "neo-trogfetch";

  runtimeInputs = with pkgs; [
    coreutils   # uname, df, cut, tr, tail, head, cat
    gnugrep
    gawk
    gnused
    ncurses     # tput
    util-linux  # lscpu
    pciutils    # lspci
    procps      # free, uptime
    iproute2    # ip
  ];

  # the script handles missing values itself; don't let errexit/pipefail abort it
  bashOptions = [ ];

  text = builtins.readFile ./neo-trogfetch;
}
