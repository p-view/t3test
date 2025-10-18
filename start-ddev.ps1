# DDEV Start-Skript für TYPO3 13
# Dieses Skript muss als Administrator ausgeführt werden!

Write-Host "=== TYPO3 13 DDEV Setup ===" -ForegroundColor Green
Write-Host ""

# Prüfe ob als Administrator ausgeführt
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "WARNUNG: Dieses Skript sollte als Administrator ausgeführt werden!" -ForegroundColor Yellow
    Write-Host "Starten Sie PowerShell als Administrator und führen Sie das Skript erneut aus." -ForegroundColor Yellow
    Write-Host ""
}

# Wechsle zum Projektverzeichnis
Set-Location W:\test\typo3test

Write-Host "Starte DDEV..." -ForegroundColor Cyan
& "C:\Program Files\DDEV\ddev.exe" start

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ DDEV erfolgreich gestartet!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Installiere TYPO3 über Composer..." -ForegroundColor Cyan
    & "C:\Program Files\DDEV\ddev.exe" composer install
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✓ TYPO3 Installation abgeschlossen!" -ForegroundColor Green
        Write-Host ""
        Write-Host "=== Zugriff auf Ihre TYPO3-Installation ===" -ForegroundColor Green
        Write-Host "Frontend: http://typo3test.ddev.site" -ForegroundColor Cyan
        Write-Host "Backend:  http://typo3test.ddev.site/typo3" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Führen Sie nun das TYPO3-Setup aus:" -ForegroundColor Yellow
        Write-Host '  & "C:\Program Files\DDEV\ddev.exe" typo3 setup' -ForegroundColor White
        Write-Host ""
        
        # Öffne Browser
        Write-Host "Öffne Browser..." -ForegroundColor Cyan
        Start-Process "http://typo3test.ddev.site"
    }
}

Write-Host ""
Write-Host "Nützliche Befehle:" -ForegroundColor Yellow
Write-Host '  Status:   & "C:\Program Files\DDEV\ddev.exe" describe' -ForegroundColor White
Write-Host '  Stoppen:  & "C:\Program Files\DDEV\ddev.exe" stop' -ForegroundColor White
Write-Host '  SSH:      & "C:\Program Files\DDEV\ddev.exe" ssh' -ForegroundColor White
Write-Host '  Logs:     & "C:\Program Files\DDEV\ddev.exe" logs' -ForegroundColor White
Write-Host ""