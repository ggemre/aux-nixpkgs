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
    rev = "d199a6cb6506f01e614eacd160f2cb0f713d9699";
    hash = "sha256-BoQ8dLdJ3MZ4tnjKM12rx7burDgLTUaso5L+7fv9XWQ=";
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
