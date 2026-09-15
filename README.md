# mac-setup

Grundausstattung für meine Macs, getrennt nach Profil:

- `work/Brewfile` – Arbeits-MacBook
- `private/Brewfile` – privates MacBook (noch nicht befüllt)

Das jeweilige `Brewfile` ist die einzige Liste, die gepflegt werden muss – es
enthält sowohl die Homebrew-Pakete als auch die manuell zu installierenden Apps
als `# MANUELL:`-Kommentarzeilen.

Das Repo ist absichtlich öffentlich, damit es sich ohne Anmeldung klonen lässt.
Es enthält deshalb ausschließlich Paketnamen – keine Konfiguration, keine
Zugangsdaten, keine internen Hostnamen.

## Neuer Rechner

```bash
git clone https://github.com/bseunig/mac-setup.git ~/mac-setup
~/mac-setup/bootstrap.sh work        # oder: private
```

Das Skript installiert bei Bedarf die Command Line Tools und Homebrew, spielt
danach das gewählte Brewfile ein und gibt am Ende die manuell zu installierenden
Apps aus.

## Einzelne Befehle

```bash
brew bundle install --file=./work/Brewfile             # installieren
brew bundle install --file=./work/Brewfile --dry-run   # nur anzeigen, was passieren würde
brew bundle check   --file=./work/Brewfile             # pruefen, ob etwas fehlt
```

Der Dry-Run ist auch die Prüfung auf ungültige oder umbenannte Tokens: nicht
existierende Casks fallen dabei sofort auf, statt erst beim Aufsetzen eines
neuen Rechners.

## App hinzufügen

Token suchen, dann ins passende Brewfile eintragen:

```bash
brew search <name>
brew info --cask <token>
```

Apps ohne Homebrew-Cask kommen als `# MANUELL: <Name> – <Quelle>` ans Ende des
Brewfiles.

## Weiteres Profil anlegen

Neues Verzeichnis mit einem `Brewfile` darin – `bootstrap.sh` findet es
automatisch und akzeptiert den Verzeichnisnamen als Argument.

## Hinweise

- **IntelliJ IDEA**: Seit dem Unified Release sind Community und Ultimate eine
  Distribution (`intellij-idea`), nutzbar ohne Lizenz mit freiem Funktionsumfang.
  `intellij-idea-ce` ist deprecated und wird am 08.12.2026 deaktiviert. Für den
  reinen Open-Source-Build gibt es alternativ `intellij-idea-oss`.
- **Logitech Options+**: Cask heißt `logi-options+`, früherer Token war
  `logi-options-plus`. Nach der Installation ist ein Neustart nötig.
- **Wireshark**: Der Cask heißt `wireshark-app`. Die gleichnamige Formula
  installiert nur die CLI-Tools.
- **App-Store-Apps** ließen sich grundsätzlich per `mas` automatisieren. Das
  setzt eine einmalige manuelle Anmeldung im App Store voraus, Bezahl-Apps
  müssen vorher regulär gekauft worden sein, und nach macOS-Updates ist `mas`
  gelegentlich defekt. Deshalb hier bewusst als manuelle Merkliste geführt.
- Lizenzschlüssel, App-Konfiguration und dotfiles gehören nicht in dieses Repo.
