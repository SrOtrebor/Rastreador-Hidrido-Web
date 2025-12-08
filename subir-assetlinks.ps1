# Script para subir assetlinks.json a GitHub

# Navegar al directorio del proyecto
cd "c:\Ernesto\Final\Rastreador-Hidrido-Web"

# Verificar que el archivo assetlinks.json existe
if (Test-Path ".well-known\assetlinks.json") {
    Write-Host "✓ Archivo assetlinks.json encontrado" -ForegroundColor Green
} else {
    Write-Host "✗ ERROR: No se encontró el archivo assetlinks.json" -ForegroundColor Red
    exit 1
}

# Agregar el archivo al staging
git add .well-known/assetlinks.json
git add manifest.json

# Crear commit
git commit -m "Agregar assetlinks.json para verificación de APK"

# Subir al repositorio
git push origin main

Write-Host "`n✓ Archivos subidos exitosamente" -ForegroundColor Green
Write-Host "`nEspera 1-2 minutos para que GitHub Pages actualice el sitio." -ForegroundColor Yellow
Write-Host "`nLuego verifica: https://srotrebor.github.io/Rastreador-Hidrido-Web/.well-known/assetlinks.json" -ForegroundColor Cyan
