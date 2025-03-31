# save-utils.ps1
# Script para respaldar y restaurar save states del juego R.E.P.O.

$repoPath = Join-Path $env:USERPROFILE "AppData\LocalLow\semiwork\Repo"
$savesPath = Join-Path $repoPath "saves"
$backupPattern = "REPO_SAVE_*"

function Select-DirectoryFromList($directories) {
    Write-Host "Se encontraron múltiples directorios:"
    for ($i = 0; $i -lt $directories.Count; $i++) {
        Write-Host "$($i + 1)) $($directories[$i].Name)"
    }
    do {
        $selection = Read-Host "Ingrese el número del directorio que desea usar"
    } while (-not ($selection -as [int]) -or $selection -lt 1 -or $selection -gt $directories.Count)
    return $directories[$selection - 1]
}

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
            Write-Host "No se encontró ningún directorio de guardado en 'saves'."
            Pause
            exit
        }

        if ($foundDirs.Count -eq 1) {
            $backupDir = $foundDirs[0]
        } else {
            $backupDir = Select-DirectoryFromList $foundDirs
        }

        Copy-Item -Path $backupDir.FullName -Destination $repoPath -Recurse -Force
        Write-Host "Backup copiado exitosamente a $repoPath."
        Pause
    }

    "2" {
        Write-Host "`nRestaurando backup..."

        if (-Not (Test-Path $repoPath)) {
            Write-Host "La carpeta 'Repo' no existe en $repoPath. Pausando ejecución."
            Pause
            exit
        }

        $foundDirs = Get-ChildItem -Path $repoPath -Directory -Filter $backupPattern

        if ($foundDirs.Count -eq 0) {
            Write-Host "No se encontró ningún directorio de guardado en 'Repo'."
            Pause
            exit
        }

        if ($foundDirs.Count -eq 1) {
            $backupDir = $foundDirs[0]
        } else {
            $backupDir = Select-DirectoryFromList $foundDirs
        }

        if (-Not (Test-Path $savesPath)) {
            Write-Host "La carpeta 'saves' no existe, se creará."
            New-Item -Path $savesPath -ItemType Directory | Out-Null
        }

        $targetRestorePath = Join-Path $savesPath $backupDir.Name

        if (Test-Path $targetRestorePath) {
            Write-Host ""
            Write-Host "⚠️  Atención: Ya existe un directorio con el mismo nombre en 'saves':"
            Write-Host "$($backupDir.Name)"
            Write-Host "Este proceso sobrescribirá su contenido."
            Write-Host ""
            $confirm = Read-Host "¿Desea continuar? Escriba 's' para confirmar"
            if ($confirm.ToLower() -ne 's') {
                Write-Host "Restauración cancelada por el usuario. No se hicieron cambios."
                Pause
                exit
            }
        }

        Copy-Item -Path $backupDir.FullName -Destination $savesPath -Recurse -Force
        Write-Host "Backup restaurado exitosamente en $savesPath."
        Pause
    }

    default {
        Write-Host "Opción no válida. Pausando ejecución."
        Pause
    }
}
