# TYPO3 mit Docker Compose starten (Alternative zu DDEV)
# Wenn DDEV Probleme macht, verwenden Sie dieses Skript

Write-Host "=== TYPO3 13 mit Docker Compose ===" -ForegroundColor Green
Write-Host ""

# Wechsle zum Projektverzeichnis
Set-Location W:\test\typo3test

Write-Host "Stoppe eventuell laufende Container..." -ForegroundColor Cyan
docker-compose down

Write-Host ""
Write-Host "Bereinige Docker-System für mehr Speicherplatz..." -ForegroundColor Cyan
docker system prune -f

Write-Host ""
Write-Host "Erstelle vereinfachte composer.json..." -ForegroundColor Cyan

# Erstelle eine Basis-composer.json mit weniger Paketen
$composerContent = @'
{
    "name": "p-view/t3test",
    "description": "TYPO3 13 Test Project",
    "type": "project",
    "require": {
        "php": "^8.2",
        "typo3/cms-core": "^13.4",
        "typo3/cms-backend": "^13.4",
        "typo3/cms-frontend": "^13.4",
        "typo3/cms-install": "^13.4",
        "typo3/cms-fluid-styled-content": "^13.4"
    },
    "config": {
        "vendor-dir": "vendor",
        "bin-dir": "vendor/bin",
        "allow-plugins": {
            "typo3/cms-composer-installers": true,
            "typo3/class-alias-loader": true
        }
    },
    "extra": {
        "typo3/cms": {
            "web-dir": "public"
        }
    }
}
'@

$composerContent | Out-File -FilePath "composer-minimal.json" -Encoding UTF8

Write-Host ""
Write-Host "Starte Docker-Container..." -ForegroundColor Cyan
docker-compose up -d

Write-Host ""
Write-Host "Warte auf Container-Start..." -ForegroundColor Cyan
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "Kopiere Basis-Composer-Konfiguration..." -ForegroundColor Cyan
docker cp composer-minimal.json typo3_web:/var/www/html/composer.json

Write-Host ""
Write-Host "Installiere TYPO3 Basis-System..." -ForegroundColor Cyan
docker exec typo3_web composer install --no-dev

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ TYPO3 Basis-Installation abgeschlossen!" -ForegroundColor Green
    Write-Host ""
    Write-Host "=== Zugriff auf Ihre TYPO3-Installation ===" -ForegroundColor Green
    Write-Host "Frontend:    http://localhost:8080" -ForegroundColor Cyan
    Write-Host "Backend:     http://localhost:8080/typo3" -ForegroundColor Cyan
    Write-Host "phpMyAdmin:  http://localhost:8081" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Datenbank-Zugangsdaten:" -ForegroundColor Yellow
    Write-Host "  Host:     db" -ForegroundColor White
    Write-Host "  Database: typo3" -ForegroundColor White
    Write-Host "  Username: typo3" -ForegroundColor White
    Write-Host "  Password: typo3" -ForegroundColor White
    Write-Host ""
    
    # Öffne Browser
    Write-Host "Öffne Browser..." -ForegroundColor Cyan
    Start-Process "http://localhost:8080"
} else {
    Write-Host ""
    Write-Host "✗ Installation fehlgeschlagen. Prüfen Sie die Logs:" -ForegroundColor Red
    Write-Host "  docker logs typo3_web" -ForegroundColor White
}

Write-Host ""
Write-Host "Nützliche Befehle:" -ForegroundColor Yellow
Write-Host "  Status:   docker ps" -ForegroundColor White
Write-Host "  Stoppen:  docker-compose down" -ForegroundColor White
Write-Host "  Logs:     docker logs typo3_web" -ForegroundColor White
Write-Host "  Shell:    docker exec -it typo3_web bash" -ForegroundColor White
Write-Host ""