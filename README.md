# Página Web Custom - Meshtastic Bridge Monitor

## Descripción

Interfaz web personalizada para visualizar nodos LoRa y datos del bridge GSM en un mapa interactivo.

## Características

✅ **Mapa interactivo** con Leaflet.js  
✅ **Visualización de nodos LoRa** (marcador azul con "L")  
✅ **Visualización de nodos GSM** (marcador rosa con "G")  
✅ **Panel lateral** con información detallada de cada nodo  
✅ **Auto-refresh** cada 10 segundos  
✅ **Diseño responsive** y moderno  

## Archivos

- `index.html` - Página principal con mapa y lista de nodos
- `README.md` - Este archivo

## Instalación

Los archivos ya están subidos al sistema de archivos LittleFS del Heltec.

### Para actualizar la página web:

1. Edita `index.html` según necesites
2. Copia el archivo a `data/static/index.html` en el proyecto
3. Ejecuta: `pio run -e heltec-wireless-tracker --target uploadfs`

## Acceso

Una vez que el Heltec esté conectado a WiFi:

**HTTP:** `http://192.168.1.99` (o la IP que obtenga)  
**HTTPS:** `https://192.168.1.99`

## API Endpoints Utilizados

La página consume los siguientes endpoints del servidor Meshtastic:

- `GET /json/nodes` - Obtiene lista de nodos con posiciones GPS

### Formato de respuesta `/json/nodes`:

```json
{
  "data": {
    "nodes": [
      {
        "id": "!ba649fcc",
        "long_name": "Meshtastic 9fcc",
        "short_name": "9fcc",
        "position": {
          "latitude": -27.451234,
          "longitude": -58.986543,
          "altitude": 50
        },
        "snr": 8.5,
        "last_heard": 1764099129
      }
    ]
  },
  "status": "ok"
}
```

## Identificación de Nodos GSM

Los nodos recibidos vía bridge GSM se identifican por:
- Nombre que contiene "GSM" en `long_name`
- Se muestran con marcador rosa y badge "GSM"

## Personalización

### Cambiar colores:

Edita las variables CSS en `<style>`:
- `#667eea` - Color principal (LoRa)
- `#f093fb` - Color GSM
- `#1a1a2e` - Fondo oscuro

### Cambiar centro del mapa:

Línea 138 en `index.html`:
```javascript
const map = L.map('map').setView([-27.4514, -58.9867], 6);
//                                  ↑ Lat      ↑ Lon    ↑ Zoom
```

### Cambiar intervalo de actualización:

Línea 267 en `index.html`:
```javascript
setInterval(refreshData, 10000); // 10000 = 10 segundos
```

## Tecnologías Utilizadas

- **HTML5** - Estructura
- **CSS3** - Estilos modernos con gradientes y animaciones
- **JavaScript (ES6+)** - Lógica de la aplicación
- **Leaflet.js 1.9.4** - Mapas interactivos
- **OpenStreetMap** - Tiles del mapa

## Notas Importantes

⚠️ **Certificado SSL:** Si accedes vía HTTPS, el navegador mostrará advertencia por certificado autofirmado. Es normal, acepta la excepción.

⚠️ **Nodos GSM:** Los nodos inyectados desde SMS aparecerán en la lista de nodos estándar. Asegúrate de que el nombre del nodo incluya "GSM" para identificación visual.

⚠️ **Espacio en filesystem:** El archivo HTML ocupa ~7KB. El filesystem tiene 1.5MB disponibles.

## Troubleshooting

**Problema:** La página no carga  
**Solución:** Verifica que el filesystem se haya subido correctamente con `pio run -e heltec-wireless-tracker --target uploadfs`

**Problema:** No aparecen nodos en el mapa  
**Solución:** Verifica que haya nodos con posición GPS válida en `/json/nodes`

**Problema:** Los nodos GSM no se identifican  
**Solución:** Asegúrate de que el `long_name` del nodo incluya "GSM" en el código del bridge

## Fecha de Creación

26 de noviembre de 2025

## Autor

Generado por Antigravity AI para el proyecto Meshtastic Bridge LoRa-GSM
