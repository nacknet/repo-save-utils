$repoPath = Join-Path $env:USERPROFILE "AppData\LocalLow\semiwork\Repo"
$savesPath = Join-Path $repoPath "saves"

$backupPattern = "REPO_SAVE_*"

Write-Host "Seleccione una opción:"
Write-Host "1) Generar backup"
Write-Host "2) Restaurar backup"
$option = Read-Host "Ingrese 1 o 2"

switch ($option) {
    "1" {
        Write-Host "`nGenerando backup..."

        if (-Not (Test-Path $savesPath)) {
            Write-Host "La carpeta 'saves' no existe en $repoPath. Pausando ejecución."
            Pause
            exit
        }

        $foundDirs = Get-ChildItem -Path $savesPath -Directory -Filter $backupPattern
        
        if ($foundDirs.Count -eq 0) {
            Write-Host "No se encontró ningún directorio de guardado en 'saves'. Pausando ejecución."
            Pause
            exit
        }
        elseif ($foundDirs.Count -gt 1) {
            Write-Host "Se encontraron múltiples directorios de guardado en 'saves'. Pausando ejecución."
            Pause
            exit
        }
        
        $backupDir = $foundDirs[0].FullName
        Write-Host "Directorio encontrado: $backupDir"
        Copy-Item -Path $backupDir -Destination $repoPath -Recurse -Force
        Write-Host "Backup generado exitosamente en $repoPath."
        Pause
    }
    "2" {
        Write-Host "`nRestaurando backup..."

        if (-Not (Test-Path $repoPath)) {
            Write-Host "La carpeta 'Repo' no existe en $env:USERPROFILE\AppData\LocalLow\semiwork. Pausando ejecución."
            Pause
            exit
        }
        
        $foundDirs = Get-ChildItem -Path $repoPath -Directory -Filter $backupPattern
        
        if ($foundDirs.Count -eq 0) {
            Write-Host "No se encontró ningún directorio de guardado en 'Repo'. Pausando ejecución."
            Pause
            exit
        }
        elseif ($foundDirs.Count -gt 1) {
            Write-Host "Se encontraron múltiples directorios de guardado en 'Repo'. Pausando ejecución."
            Pause
            exit
        }
        
        $backupDir = $foundDirs[0].FullName
        Write-Host "Directorio encontrado: $backupDir"
        
        if (-Not (Test-Path $savesPath)) {
            Write-Host "La carpeta 'saves' no existe, se creará."
            New-Item -Path $savesPath -ItemType Directory | Out-Null
        }
        Copy-Item -Path $backupDir -Destination $savesPath -Recurse -Force
        Write-Host "Backup restaurado exitosamente en $savesPath."
        Pause
    }
    default {
        Write-Host "Opción no válida. Pausando ejecución."
        Pause
    }
}
