# Nix Package Set

![Build and populate cache](https://github.com/ggemre/aux-nixpkgs/workflows/Build%20and%20deploy/badge.svg)
[![Cachix Cache](https://img.shields.io/badge/cachix-ggemre.svg)](https://ggemre.cachix.org)

Set of nix packages for my personal use to serve an auxiliary purpose to [nixpkgs](https://github.com/nixos/nixpkgs).

## Packages

| Name | Description | Notes |
| ---- | ----------- | ----- |
| alejandra-spaced | The Alejandra formatter with spaces around elements. | |
| mangowm-wlonly | MangoWM without scenefx. | (git version) |

## Usage

Add the flake like so:

```nix
inputs.aux-nixpkgs.url = "github:ggemre/aux-nixpkgs";
```

> [!NOTE]
> Overriding the nixpkgs input could render the cache useless if there is a mismatch.
> Currently, I only build & cache for `nixos-unstable`.

Any package from this flake can be accessed as flake outputs. For example, using legacyPackages:

```nix
inputs.aux-nixpkgs.legacyPackages.<SYSTEM>.<PACKAGE>
```

#### Cachix Support

It is optional but recommended to use Cachix with this flake to avoid building packages from source.

Substituter Information:
* Address: `https://ggemre.cachix.org`
* Public Key: `ggemre.cachix.org-1:ULcTF3sXFvs42La9WBB+hUOLuI3eFExxQBpRMgOzTdo=`

The cache only contains binaries for `x86_64-linux`. To save space and costs, I don't plan on supporting multiple systems.

## Images

This repository also builds a couple of NixOS images. You can check [releases](https://github.com/ggemre/aux-nixpkgs/releases),
but bear in mind these are tailored to my systems and may not work correctly on your hardware. Use at your own risk.

## Notes

* Open an [issue](https://github.com/ggemre/aux-nixpkgs/issues) if you need to contact me.
  - Licensing concerns
  - Package / update requests
  - Security concerns
