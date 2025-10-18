# TYPO3 13 Test-Projekt

## Projektübersicht
Dieses Projekt ist ein TYPO3 13 Test-Setup mit Docker und DDEV.

## Voraussetzungen
- Docker Desktop (✅ installiert)
- DDEV v1.24.8 (✅ installiert unter `C:\Program Files\DDEV\ddev.exe`)
- Git (✅ installiert)

## Installation mit DDEV (Empfohlen)

### 1. DDEV-Alias einrichten (optional)
Um `ddev` direkt zu verwenden, fügen Sie dies zu Ihrem PowerShell-Profil hinzu:
```powershell
Set-Alias ddev "C:\Program Files\DDEV\ddev.exe"
```

Oder führen Sie DDEV mit dem vollständigen Pfad aus:
```powershell
& "C:\Program Files\DDEV\ddev.exe"
```

### 2. Projekt mit DDEV starten

```powershell
# Im Projektverzeichnis
cd W:\test\typo3test

# DDEV starten (als Administrator ausführen für Hostname-Verwaltung)
& "C:\Program Files\DDEV\ddev.exe" start

# TYPO3 über Composer installieren
& "C:\Program Files\DDEV\ddev.exe" composer install

# TYPO3 Setup durchführen
& "C:\Program Files\DDEV\ddev.exe" typo3 setup
```

### 3. Zugriff auf die Anwendung

Nach erfolgreicher Installation ist TYPO3 verfügbar unter:
- **Frontend**: http://typo3test.ddev.site
- **Backend**: http://typo3test.ddev.site/typo3

### DDEV-Befehle

```powershell
# Projekt starten
& "C:\Program Files\DDEV\ddev.exe" start

# Projekt stoppen
& "C:\Program Files\DDEV\ddev.exe" stop

# SSH in den Container
& "C:\Program Files\DDEV\ddev.exe" ssh

# Composer ausführen
& "C:\Program Files\DDEV\ddev.exe" composer [command]

# Datenbank-Import
& "C:\Program Files\DDEV\ddev.exe" import-db --file=backup.sql

# Projekt-Status anzeigen
& "C:\Program Files\DDEV\ddev.exe" describe

# Logs ansehen
& "C:\Program Files\DDEV\ddev.exe" logs
```

## Alternative: Docker Compose

Falls DDEV Probleme macht, können Sie auch Docker Compose direkt verwenden:

```powershell
# Container starten
docker-compose up -d

# TYPO3 ist dann verfügbar unter:
# - Frontend: http://localhost:8080
# - phpMyAdmin: http://localhost:8081
# - Datenbank: localhost:3306
```

## Datenbank-Zugangsdaten

```
Host: db (im Container) / localhost:3306 (von außen)
Database: typo3
Username: typo3
Password: typo3
Root Password: root
```

## Projektstruktur

```
W:\test\typo3test\
├── .ddev/              # DDEV-Konfiguration
├── .git/               # Git-Repository  
├── config/             # TYPO3-Konfiguration (wird generiert)
├── docker/             # Docker-Konfiguration
├── public/             # Webroot (index.php, etc.)
├── var/                # Temporäre Dateien, Cache
├── vendor/             # Composer-Abhängigkeiten
├── .gitignore          # Git-Ignore-Datei
├── composer.json       # Composer-Konfiguration
├── docker-compose.yml  # Docker Compose-Konfiguration
└── README.md           # Diese Datei
```

## Troubleshooting

### Problem: "ddev-hostname.exe not found"
**Lösung**: Führen Sie PowerShell als Administrator aus oder verwenden Sie die docker-compose.yml direkt.

### Problem: "No space left on device"
**Lösung**: Docker-Volumes bereinigen:
```powershell
docker system prune -a --volumes
```

### Problem: Volumes werden nicht gemountet
**Lösung**: Bei Netzlaufwerken kann es zu Problemen kommen. Verwenden Sie DDEV, da es besser mit Netzlaufwerken umgeht.

## GitHub-Repository

https://github.com/p-view/t3test

## Nächste Schritte

1. TYPO3 Backend-Benutzer erstellen
2. Erste Website/Seite anlegen
3. Template konfigurieren
4. Extensions installieren

## Hilfreiche Links

- [TYPO3 13 Dokumentation](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/)
- [DDEV Dokumentation](https://ddev.readthedocs.io/)
- [TYPO3 Composer Template](https://github.com/TYPO3/TYPO3.CMS.BaseDistribution)
