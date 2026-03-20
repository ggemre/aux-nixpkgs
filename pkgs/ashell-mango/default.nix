{
  fetchFromGitHub,
  lib,
  rustPlatform,
  autoPatchelfHook,
  pkg-config,
  libxkbcommon,
  libGL,
  pipewire,
  libpulseaudio,
  wayland,
  udev,
  vulkan-loader,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "ashell";
  version = lib.substring 0 7 finalAttrs.src.rev;

  src = fetchFromGitHub {
    owner = "MalpenZibo";
    repo = "ashell";
    rev = "6d545bac56b6f40ac2a7f2a5818fd822fb5c6313";
    hash = "sha256-b6aVPbo2kRYMxEuMNkBg2VQiSHIa7+VLEbVyLerWN3U=";
  };

  cargoHash = "sha256-1QpcCcblqAhCCXqNbZYmnO2m3aqFbjKuRTJYG+b7fMQ=";

  nativeBuildInputs = [
    pkg-config
    autoPatchelfHook
    rustPlatform.bindgenHook
  ];

  runtimeDependencies = [
    wayland
    libGL
    vulkan-loader
  ];

  buildInputs = [
    libpulseaudio
    libxkbcommon
    pipewire
    udev
  ]
  ++ finalAttrs.runtimeDependencies;

  patches = [
    ./mango.patch
  ];

  meta = {
    description = "Ready to go Wayland status bar for Hyprland";
    homepage = "https://github.com/MalpenZibo/ashell";
    license = lib.licenses.mit;
    mainProgram = "ashell";
    maintainers = with lib.maintainers; [ justdeeevin ];
    platforms = lib.platforms.linux;
  };
})
