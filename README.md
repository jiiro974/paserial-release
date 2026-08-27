# paserial

CLI pour exécuter des fichiers de commandes PAN-OS sur un firewall Palo Alto **via console série** — sans SSH, sans API.

> Ce dépôt héberge uniquement les binaires compilés. Le code source est privé.

---

## Téléchargement

| Plateforme | Binaire |
|------------|---------|
| Linux x86-64 | [paserial-linux-amd64](../../releases/latest/download/paserial-linux-amd64) |
| Linux ARM64 | [paserial-linux-arm64](../../releases/latest/download/paserial-linux-arm64) |
| macOS Intel | [paserial-darwin-amd64](../../releases/latest/download/paserial-darwin-amd64) |
| macOS Apple Silicon | [paserial-darwin-arm64](../../releases/latest/download/paserial-darwin-arm64) |
| Windows x86-64 | [paserial-windows-amd64.exe](../../releases/latest/download/paserial-windows-amd64.exe) |

Page de téléchargement : https://jiiro974.github.io/paserial-release/

---

## Installation

### Linux / macOS

```bash
curl -Lo paserial https://github.com/jiiro974/paserial-release/releases/latest/download/paserial-$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m | sed s/x86_64/amd64/)
chmod +x paserial
sudo mv paserial /usr/local/bin/
```

### Windows

PowerShell **en administrateur** — bootstrap complet (binaire, PATH, firewall, service, config) :

```powershell
irm https://github.com/jiiro974/paserial-release/releases/latest/download/install.ps1 | iex
```

Alternative : télécharger `paserial-windows-amd64.exe` depuis la [page des releases](../../releases/latest) et le placer dans un répertoire inclus dans le `PATH`.

### Vérification de l'intégrité

```bash
# Télécharger checksums.txt et vérifier
curl -Lo checksums.txt https://github.com/jiiro974/paserial-release/releases/latest/download/checksums.txt
sha256sum -c checksums.txt --ignore-missing
```

---

## Mise à jour

```bash
paserial self-update
```

---

## Usage rapide

```bash
# Upgrade firmware
paserial --port /dev/ttyUSB0 --yes upgrade-10.2.8.txt

# Dry-run (simulation sans exécution)
paserial --port /dev/ttyUSB0 --dry-run upgrade-10.2.8.txt

# Diagnostic connectivité / Panorama
paserial debug-panorama --port /dev/ttyUSB0

# Version installée
paserial version
```

### Flags principaux

| Flag | Défaut | Description |
|------|--------|-------------|
| `--port` | requis | Port série (`COM3`, `/dev/ttyUSB0`, `/dev/cu.usbserial-*`) |
| `--baud` | 9600 | Baud rate |
| `-f`, `--force` | false | Continuer sans pause si erreur détectée |
| `--yes` | false | Répondre `y` aux confirmations PAN-OS |
| `--timeout` | 30m | Timeout par commande |
| `--dry-run` | false | Afficher les étapes sans les exécuter |
| `--var KEY=VAL` | — | Variable pour `{{KEY}}` dans le fichier de commandes |
| `--debug-bundle` | false | Générer une archive ZIP de diagnostic en cas d'erreur |

---

## Prérequis

- Firewall Palo Alto accessible via câble console (USB-série ou DB9)
- Port série reconnu par l'OS (`9600 8N1` par défaut)
- Compte CLI avec droits suffisants (`admin` ou équivalent)
- Connectivité Internet depuis le firewall (pour les downloads de firmware/content)

---

## Releases

Voir la liste complète des versions : [Releases](../../releases)
