# Rastreador GPS Híbrido LoRa/GSM

## Descripción

Aplicación web progresiva (PWA) para proyecto final de Ingeniería Electrónica. Sistema de rastreo GPS que reporta datos por red LoRa y cambia automáticamente a GSM cuando sale de rango, optimizado para uso móvil.

## Características Principales

✅ **Diseño Mobile-First** - Optimizado para dispositivos móviles  
✅ **Mapa Interactivo Fullscreen** - Leaflet.js con visualización clara  
✅ **Barra de Telemetría Colapsable** - Muestra potencia señal, batería y distancia  
✅ **Detección Automática LoRa/GSM** - Identificación visual del tipo de conexión  
✅ **Registro de Eventos Críticos** - Captura momentos de cambio LoRa ↔ GSM  
✅ **Web Bluetooth API** - Conexión directa con el dispositivo (Android)  
✅ **Exportación de Datos** - CSV y JSON para análisis e informes  
✅ **PWA Instalable** - Funciona como app nativa en móvil  
✅ **Almacenamiento Local** - IndexedDB para histórico de datos  

## Archivos del Proyecto

- `index.html` - Aplicación web principal
- `manifest.json` - Configuración PWA
- `service-worker.js` - Cache y funcionamiento offline
- `README.md` - Esta documentación

## Instalación en Dispositivo Heltec

### Subir archivos al filesystem:

1. Copia todos los archivos a `data/static/` en el proyecto
2. Ejecuta: `pio run -e heltec-wireless-tracker --target uploadfs`

## Acceso a la Aplicación

**HTTP:** `http://192.168.1.99` (o la IP asignada)  
**HTTPS:** `https://192.168.1.99`

### Instalar como PWA en Android:

1. Abre la aplicación en Chrome
2. Menú → "Agregar a pantalla de inicio"
3. La app se instalará como nativa

## API Endpoints

### `GET /json/nodes`

Obtiene lista de nodos con datos de telemetría.

**Formato esperado:**
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
        "battery": 85,
        "last_heard": 1764099129
      }
    ]
  },
  "status": "ok"
}
```

## Funcionalidades Detalladas

### 1. Barra de Telemetría

**Ubicación:** Parte superior de la pantalla, debajo del header  
**Estados:** Colapsada (1 línea) o Expandida (3 líneas)  
**Interacción:** Tap en el ícono ▼ para expandir/contraer

**Datos mostrados:**
- 📶 **Tipo de Señal:** LoRa o GSM (detectado automáticamente)
- **Potencia:** SNR en dBm
- 🔋 **Batería:** Porcentaje del dispositivo
- 📏 **Distancia:** Calculada desde tu ubicación

### 2. Sistema de Registro

**Motor:** IndexedDB (base de datos local del navegador)

**Eventos registrados:**
- ✅ Cambios LoRa → GSM con telemetría completa
- ✅ Cambios GSM → LoRa con telemetría completa
- ✅ Timestamp preciso de cada evento
- ✅ Datos de posición GPS en el momento del cambio

**Propósito:** Generar informes técnicos para el trabajo final de ingeniería.

### 3. Exportación de Datos

**Formatos disponibles:**
- **CSV:** Para análisis en Excel/Google Sheets
- **JSON:** Para procesamiento programático

**Datos exportados:**
```csv
Timestamp, Fecha, De, A, Latitud, Longitud, SNR, Batería
1764099129, 27/11/2025 22:30:45, LoRa, GSM, -27.451234, -58.986543, 8.5, 85
```

**Uso:** Botón 💾 en header → Seleccionar formato → Descarga automática

### 4. Conexión Bluetooth (Android)

**Requisitos:**
- Navegador Chrome en Android
- Bluetooth habilitado en el dispositivo

**Uso:**
1. Tap en botón 📡 en header
2. "Conectar" → Seleccionar dispositivo
3. Los datos se recibirán en tiempo real

**Nota:** Requiere configuración del UUID de servicio Bluetooth en el código según tu dispositivo.

### 5. Bottom Sheet de Nodos

**Ubicación:** Panel deslizable desde abajo  
**Interacción:** Swipe up para expandir, swipe down para minimizar  
**Contenido:** Lista de todos los nodos activos con detalles

## Personalización

### Cambiar centro del mapa:

Línea 461 en `index.html`:
```javascript
const CONFIG = {
    mapCenter: [-27.4514, -58.9867], // Cambiar coordenadas
    mapZoom: 6,
    // ...
};
```

### Cambiar intervalo de actualización:

```javascript
refreshInterval: 10000, // 10 segundos (en milisegundos)
```

### Cambiar colores:

Variables CSS principales:
- `#667eea` - Color LoRa (morado)
- `#f093fb` - Color GSM (rosa)
- `#1a1a2e` - Fondo oscuro
- `#16213e` - Paneles

## Tecnologías Utilizadas

- **HTML5 + CSS3** - Estructura y estilos modernos
- **JavaScript ES6+** - Lógica de aplicación
- **Leaflet.js 1.9.4** - Mapas interactivos
- **OpenStreetMap** - Tiles del mapa
- **IndexedDB** - Almacenamiento local
- **Web Bluetooth API** - Conexión Bluetooth
- **Geolocation API** - Ubicación del usuario
- **PWA** - Instalación en móvil

## Notas Importantes

⚠️ **Bluetooth:** Solo funciona en Chrome/Edge en Android. iOS no soporta Web Bluetooth API.

⚠️ **HTTPS:** Para Bluetooth y Geolocalización, el sitio debe estar en HTTPS. Si usas HTTP local, algunas funciones pueden no estar disponibles.

⚠️ **Almacenamiento:** IndexedDB almacena datos en el navegador del dispositivo. No se sincronizan entre dispositivos.

⚠️ **Batería:** El campo `battery` debe estar presente en el JSON del endpoint `/json/nodes`. Si no existe, mostrará `--`.

## Troubleshooting

**Problema:** La barra de telemetría no muestra datos  
**Solución:** Verifica que el endpoint `/json/nodes` devuelva los campos `snr` y `battery`

**Problema:** No detecta cambios LoRa/GSM  
**Solución:** Asegúrate que el `long_name` en el JSON incluya "GSM" cuando esté en modo GSM

**Problema:** Bluetooth no conecta  
**Solución:** Verifica que estés usando Chrome en Android y que el UUID de servicio Bluetooth esté configurado correctamente

**Problema:** No se puede exportar datos  
**Solución:** Debe haber eventos registrados. Espera a que ocurra al menos un cambio LoRa↔GSM

**Problema:** La app no se puede instalar como PWA  
**Solución:** Necesitas servir la aplicación vía HTTPS. En desarrollo local puedes usar `ngrok` o similar.

## Uso para Proyecto Final

### Datos para el Informe

La aplicación registra específicamente:

1. **Eventos de Cambio de Red:**
   - Timestamp exacto
   - Tipo de cambio (LoRa→GSM o GSM→LoRa)
   - Posición GPS en ese momento
   - Potencia de señal (SNR)
   - Nivel de batería

2. **Análisis Posible:**
   - Frecuencia de cambios LoRa/GSM
   - Zonas geográficas donde ocurren cambios
   - Correlación señal/distancia
   - Consumo de batería en cada modo

### Procedimiento Recomendado

1. Iniciar la aplicación antes de la prueba de campo
2. Permitir geolocalización para cálculo de distancias
3. Dejar registrando durante toda la prueba
4. Al finalizar, exportar datos en CSV
5. Analizar en Excel/Python para el informe

## Fecha de Creación

27 de noviembre de 2025

## Autores

- Proyecto: Estudiante de Ingeniería Electrónica
- Desarrollo Web: Antigravity AI
- Propósito: Trabajo Final de Carrera

---

**Versión:** 2.0 Mobile-First  
**Última actualización:** 27/11/2025
