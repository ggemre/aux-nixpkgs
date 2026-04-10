#! /usr/bin/env bash
set -euo pipefail
nix run nixpkgs#nix-update -- mangowm-wlonly --flake --version=branch=wl-only
