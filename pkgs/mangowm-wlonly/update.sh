#! /usr/bin/env bash
set -euo pipefail
nix run nixpkgs#nix-update -- mangowm-wlonly --flake --version=branch=wl-only
nix shell nixpkgs#gnused -c sed -i 's/version = "[A-Za-z0-9.-]*";/version = "wl-only-git";/' pkgs/mangowm-wlonly/default.nix 
