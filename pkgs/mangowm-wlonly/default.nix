{
  callPackage,
  fetchFromGitHub,
  lib,
  libX11,
  libinput,
  libxcb,
  libxkbcommon,
  pcre2,
  pixman,
  pkg-config,
  stdenv,
  wayland,
  wayland-protocols,
  wayland-scanner,
  libxcb-wm,
  xwayland,
  meson,
  ninja,
  # wlroots_0_20,
  libGL,
  enableXWayland ? true,
}: let
  # TODO: rm when upstream:
  wlroots_0_20 = callPackage ./wlroots.nix {};
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "mango";
    version = "wl-only-git";

    src = fetchFromGitHub {
      owner = "mangowm";
      repo = "mango";
      rev = "8e8710ea7618cc4a5ff22be463448c253a6265c6";
      hash = "sha256-QpVvSQM3j5YAUjMhB3vZtyxfa2wuDy0geshHpYS8iuA=";
    };

    mesonFlags = [
      (lib.mesonEnable "xwayland" enableXWayland)
    ];

    nativeBuildInputs = [
      meson
      ninja
      pkg-config
      wayland-scanner
    ];

    buildInputs =
      [
        libinput
        libxcb
        libxkbcommon
        pcre2
        pixman
        wayland
        wayland-protocols
        wlroots_0_20
        libGL
      ]
      ++ lib.optionals enableXWayland [
        libX11
        libxcb-wm
        xwayland
      ];

    passthru = {
      providedSessions = ["mango"];
    };

    meta = {
      mainProgram = "mango";
      description = "MangoWM without scenefx.";
      homepage = "https://github.com/mangowm/mango";
      license = lib.licenses.gpl3Plus;
      maintainers = [];
      platforms = lib.platforms.linux;
    };
  })
