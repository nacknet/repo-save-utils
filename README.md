# 🧰 Repo Save Utils

Este repositorio contiene un script de PowerShell llamado `save-utils.ps1`, diseñado para facilitar el respaldo y la restauración de archivos de guardado (save states) del juego [R.E.P.O](https://store.steampowered.com/app/3241660/REPO/?l=spanish).

El script trabaja sobre las rutas locales donde el juego almacena sus archivos de guardado, y permite automatizar su copia o restauración de forma segura.

## ⚙️ Funcionalidades

Al ejecutar el script, se presentan dos opciones:

1. **Generar Backup**
   - Busca en la carpeta `saves` un directorio con el formato:  
     `REPO_SAVE_YYYY_MM_DD_HH_MM_SS`
   - Si encuentra un único directorio con ese formato, lo copia a la carpeta principal `Repo`.
   - Si no encuentra ninguno o encuentra múltiples, lo notifica y detiene la ejecución.

2. **Restaurar Backup**
   - Busca en la carpeta principal `Repo` un directorio con el mismo formato `REPO_SAVE_YYYY_MM_DD_HH_MM_SS`.
   - Si encuentra un único directorio, lo copia a la carpeta `saves`.
   - Si no encuentra ninguno o encuentra múltiples, lo notifica y detiene la ejecución.

## ✅ Requisitos

- Sistema operativo: **Windows**
- No requiere instalación de software adicional.
- Compatible con **PowerShell 5.1 o superior** (incluido por defecto en Windows 10 y 11).

## 📁 Rutas utilizadas

El script trabaja con las siguientes rutas (de forma dinámica según el usuario actual):

- Carpeta principal del juego:  
  `%USERPROFILE%\AppData\LocalLow\semiwork\Repo`

- Carpeta de guardados:  
  `%USERPROFILE%\AppData\LocalLow\semiwork\Repo\saves`

## 🚀 Cómo usarlo

1. **Clonar o descargar este repositorio**

```bash
git clone https://github.com/tu-usuario/repo-save-utils.git
cd repo-save-utils
```

2. **(Opcional pero recomendado) Permitir la ejecución de scripts de PowerShell**

   Por defecto, Windows restringe la ejecución de scripts por seguridad. Para permitir la ejecución del script, abre PowerShell como **Administrador** y ejecuta el siguiente comando:

   Set-ExecutionPolicy RemoteSigned

   Selecciona `Y` (Yes) cuando se te pregunte si deseas cambiar la política.

   💡 Este paso solo es necesario una vez por equipo, y puedes revertirlo más adelante si lo deseas con:

   Set-ExecutionPolicy Restricted

3. **Ejecutar el script**

   .\save-utils.ps1

4. **Seleccionar una opción en pantalla**

   Sigue las instrucciones para generar o restaurar un backup.

## 🧠 Notas

- El script usa la variable de entorno `%USERPROFILE%` para detectar automáticamente la ruta del usuario actual, por lo que funciona en cualquier equipo con Windows.
- Actualmente, si hay múltiples directorios de guardado, el script lo notifica y detiene la ejecución. En el futuro se planea agregar la opción de seleccionar cuál guardar o restaurar.
- Es útil para compartir tus partidas guardadas o mantener respaldos seguros antes de experimentar dentro del juego.

## 🛡️ Licencia

Este proyecto está bajo la licencia MIT. Puedes copiar, modificar y compartir libremente este código.

---

¡Contribuciones, mejoras y sugerencias son bienvenidas! 🎮💾
