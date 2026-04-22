# Basic script to reinstall a basic system
# Run with `reinstall <HOSTNAME>` to reinstall HOSTNAME

deps_not_satisfied=false

if ! command -v disko >/dev/null 2>&1; then
	echo -e "\033[0;31mERROR:\033[0m disko must be installed and available to run this script"
  deps_not_satisfied=true
elif ! command -v curl >/dev/null 2>&1; then
	echo -e "\033[0;31mERROR:\033[0m curl must be installed and available to run this script"
  deps_not_satisfied=true
fi

if $deps_not_satisfied; then
	exit 1
fi

HOST=$1

if [ -z "$HOST" ]; then
	echo -e "\033[0;31mERROR:\033[0m argument HOST not provided"
	echo "Run this command with ./install <HOST>"
	exit 1
fi

DISK_URL="https://raw.githubusercontent.com/ggemre/nixos-config/refs/heads/main/hosts/$HOST/disk.nix"

echo "Installing NixOS for machine named $HOST..."

if ! curl -sf "$DISK_URL" -o disk.nix; then
	echo -e "\033[0;31mERROR:\033[0m disk configuration for $HOST not found"
	exit 1
fi

sudo disko --mode destroy,format,mount --yes-wipe-all-disks disk.nix
sudo nixos-install --no-channel-copy --no-root-passwd --flake github:ggemre/nixos-config#$HOST
echo "Installation complete. You may now reboot."

