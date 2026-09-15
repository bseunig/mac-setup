#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="${1:-}"
BREWFILE="$REPO_DIR/$PROFILE/Brewfile"

if [[ -z "$PROFILE" || ! -f "$BREWFILE" ]]; then
  echo "Aufruf: $(basename "$0") <profil>"
  printf "Verfuegbar:"
  for f in "$REPO_DIR"/*/Brewfile; do printf " %s" "$(basename "$(dirname "$f")")"; done
  echo
  exit 1
fi

# Xcode Command Line Tools – Voraussetzung fuer Homebrew.
# Die Installation laeuft als GUI-Dialog und laesst sich nicht abwarten.
if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Command Line Tools werden installiert."
  xcode-select --install
  echo "    Nach Abschluss der Installation dieses Skript erneut starten."
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "==> Homebrew wird installiert."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# brew in die PATH der laufenden Shell holen – der Installer schreibt das nur
# nach .zprofile, was erst in der naechsten Shell-Sitzung greift.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "==> Profil '$PROFILE' wird installiert."
brew bundle install --file="$BREWFILE"

# || true, weil grep ohne Treffer mit 1 endet und set -e sonst abbricht
MANUAL="$(grep '^# MANUELL: [^(]' "$BREWFILE" || true)"
if [[ -n "$MANUAL" ]]; then
  echo
  echo "==> Noch manuell zu installieren:"
  sed 's/^# MANUELL: /    - /' <<< "$MANUAL"
fi

echo
echo "==> Fertig."
