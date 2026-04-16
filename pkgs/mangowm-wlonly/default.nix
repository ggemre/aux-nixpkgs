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
  wlroots_0_20,
  libGL,
  enableXWayland ? true,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "mango";
  version = builtins.substring 0 7 finalAttrs.src.rev;

  src = fetchFromGitHub {
    owner = "mangowm";
    repo = "mango";
    rev = "36978537ffa97310165c0565d2022191d267d29c";
    hash = "sha256-Yf3Gp7mLz2qCkCFqd27rgEJQY+rAtTrAp6ofw/szUvE=";
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
    platforms = lib.platforms.linux;
  };
})
