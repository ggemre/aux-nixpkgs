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
  version = "wl-only-git";

  src = fetchFromGitHub {
    owner = "mangowm";
    repo = "mango";
    rev = "92aaee41bbd611b40c9bc6fdcda3e380877292b8";
    hash = "sha256-b44beVifnvSUu0Q3Nfa0+z6OcaTYt7rems4akuYp5F0=";
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
