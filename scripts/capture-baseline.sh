#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: bash %s OUTPUT_DIRECTORY\n' "${0##*/}"
  printf 'Run inside the Arch VM as your normal user. The output must not exist.\n'
}

if [[ ${1:-} == --help || ${1:-} == -h ]]; then
  usage
  exit 0
fi

if (($# != 1)); then
  usage >&2
  exit 2
fi

if ((EUID == 0)); then
  printf 'Run as your desktop user without sudo so the correct configuration is captured.\n' >&2
  exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
  printf 'pacman is missing. Run this script inside the installed Arch VM.\n' >&2
  exit 1
fi

output_dir=$1
config_dir=${XDG_CONFIG_HOME:-"$HOME/.config"}

# Plain mkdir deliberately refuses existing paths, including symlinks.
mkdir -- "$output_dir"
mkdir -- "$output_dir/packages" "$output_dir/config"

pacman -Qqe >"$output_dir/packages/explicit.txt"
pacman -Q >"$output_dir/packages/versions.txt"

copied=0
for relative_path in hypr/hyprland.lua hypr/hyprland.conf kitty/kitty.conf; do
  if [[ -f "$config_dir/$relative_path" ]]; then
    mkdir -p -- "$output_dir/config/$(dirname -- "$relative_path")"
    cp -- "$config_dir/$relative_path" "$output_dir/config/$relative_path"
    copied=$((copied + 1))
  fi
done

if ((copied == 0)); then
  printf 'No Hyprland or Kitty configuration was found under %s.\n' "$config_dir" >&2
  printf 'Package inventories were saved, but this capture is incomplete.\n' >&2
  exit 1
fi

{
  printf 'Captured at: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'Kernel: %s\n' "$(uname -r)"
  printf 'Configuration files copied: %s\n' "$copied"
  printf 'Package versions are an inventory, not a repository snapshot.\n'
  printf 'Imported configuration files and assets require separate capture.\n'
} >"$output_dir/CAPTURE.txt"

printf 'Baseline saved to %s\n' "$output_dir"
