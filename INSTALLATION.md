# TYPO3 13 Installation - Schnellanleitung

## Problem: "wird nicht gefunden"

Das bedeutet wahrscheinlich, dass TYPO3 noch nicht vollständig installiert ist oder die URL nicht erreichbar ist.

## ✅ Empfohlene Lösung: DDEV verwenden (ALS ADMINISTRATOR!)

### Schritt 1: PowerShell als Administrator starten
1. Windows-Taste drücken
2. "PowerShell" eingeben  
3. **Rechtsklick** auf "Windows PowerShell"
4. **"Als Administrator ausführen"** wählen

### Schritt 2: TYPO3 installieren

```powershell
# Zum Projektverzeichnis wechseln
cd W:\test\typo3test

# DDEV starten
& "C:\Program Files\DDEV\ddev.exe" start

# TYPO3 installieren
& "C:\Program Files\DDEV\ddev.exe" composer install

# TYPO3-Setup ausführen
& "C:\Program Files\DDEV\ddev.exe" exec vendor/bin/typo3 setup

# Browser öffnen
Start-Process "http://typo3test.ddev.site"
```

### Schritt 3: TYPO3 einrichten

Wenn der Browser sich öffnet:
1. Wählen Sie "Create empty starting page"
2. Geben Sie Admin-Zugangsdaten ein:
   - **Username**: admin
   - **Password**: (Ihr Wunschpasswort, mind. 8 Zeichen)
3. Datenbankdaten werden automatisch erkannt

---

## Alternative: Manuelle Installation ohne DDEV

Falls DDEV nicht funktioniert:

### Option A: TYPO3 direkt herunterladen

```powershell
cd W:\test\typo3test

# Erstelle minimale Struktur
New-Item -ItemType Directory -Path "public" -Force

# Lade TYPO3 Introduction Package
Invoke-WebRequest -Uri "https://get.typo3.org/13" -OutFile "typo3_src.zip"
Expand-Archive -Path "typo3_src.zip" -DestinationPath "public"

# Starte einfachen PHP-Server (benötigt PHP auf dem System)
php -S localhost:8000 -t public
```

### Option B: DDEV mit Quickstart verwenden

```powershell
cd W:\test\typo3test

# DDEV mit offiziellem TYPO3-Quickstart
& "C:\Program Files\DDEV\ddev.exe" config --project-type=typo3 --php-version=8.2
& "C:\Program Files\DDEV\ddev.exe" start
& "C:\Program Files\DDEV\ddev.exe" composer create "typo3/cms-base-distribution:^13"
```

---

## Troubleshooting

### Problem: "ddev-hostname.exe not found"
**Lösung**: Sie müssen PowerShell **als Administrator** ausführen!

### Problem: "No space left on device"  
**Lösung**: Docker bereinigen:
```powershell
docker system prune -a --volumes
```

### Problem: URL wird nicht gefunden
**Lösung 1**: Hosts-Datei manuell bearbeiten (als Administrator):
```powershell
Add-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value "127.0.0.1 typo3test.ddev.site"
```

**Lösung 2**: Localhost verwenden:
```powershell
& "C:\Program Files\DDEV\ddev.exe" config --additional-fqdns=localhost
& "C:\Program Files\DDEV\ddev.exe" start
```
Dann über http://localhost:8080 zugreifen

---

## Schnellstart-Befehl (Als Administrator!)

Kopieren Sie diesen kompletten Block und führen Sie ihn in PowerShell (als Admin) aus:

```powershell
cd W:\test\typo3test
& "C:\Program Files\DDEV\ddev.exe" stop
& "C:\Program Files\DDEV\ddev.exe" delete -y
& "C:\Program Files\DDEV\ddev.exe" config --project-type=typo3 --php-version=8.2 --docroot=public
& "C:\Program Files\DDEV\ddev.exe" start  
& "C:\Program Files\DDEV\ddev.exe" composer create "typo3/cms-base-distribution:^13" --no-interaction
& "C:\Program Files\DDEV\ddev.exe" launch
```

---

## URLs nach Installation

- **TYPO3 Frontend**: http://typo3test.ddev.site
- **TYPO3 Backend**: http://typo3test.ddev.site/typo3
- **Datenbank**: http://typo3test.ddev.site:8036 (PHPMyAdmin über DDEV)

---

## Hilfe benötigt?

Führen Sie diese Befehle aus um den Status zu prüfen:

```powershell
# DDEV-Status
& "C:\Program Files\DDEV\ddev.exe" describe

# Container-Status
docker ps

# DDEV-Logs
& "C:\Program Files\DDEV\ddev.exe" logs
```