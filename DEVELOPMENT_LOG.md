# Log de Desarrollo - Rastreador GPS Híbrido

## Fecha: 28-29 de Noviembre de 2025

---

## 📋 Resumen del Proyecto

**Proyecto**: Sistema de rastreo GPS híbrido LoRa/GSM para trabajo final de Ingeniería Electrónica  
**Hardware**: Dispositivos Heltec Wireless Tracker con Meshtastic  
**Web App**: PWA (Progressive Web App) para visualización en mapa interactivo  
**Ubicación**: Corrientes, Argentina

---

## ✅ Estado Actual del Proyecto

### Completado:
1. ✅ Aplicación web funcional con mapa interactivo (Leaflet.js)
2. ✅ Barra de telemetría colapsable (señal, batería, distancia)
3. ✅ Detección automática LoRa/GSM (basado en `long_name`)
4. ✅ Sistema de registro de eventos (IndexedDB)
5. ✅ Exportación de datos (CSV/JSON)
6. ✅ Soporte Web Bluetooth API (Android)
7. ✅ PWA instalable en móviles
8. ✅ Bottom sheet con lista de nodos activos
9. ✅ Archivo de datos de prueba creado (`json/nodes`)
10. ✅ Servidor HTTP local funcionando (Python)
11. ✅ Repositorio Git configurado

### En Progreso:
- ⚠️ **Optimización diseño móvil**: Intentos de reducir tamaños de fuente en telemetría
  - **Problema**: Archivo `index.html` se corrompe al editar con herramientas automáticas
  - **Solución temporal**: Restaurado a versión original con `git restore`
  - **Pendiente**: Aplicar cambios CSS manualmente o con método más robusto

### Pendiente:
- ❌ Integración con firmware Heltec real
- ❌ Ajuste de coordenadas GPS (actualmente muestra ubicación incorrecta)
- ❌ Optimización de tamaños de fuente para móviles
- ❌ Testing con dispositivos reales en Corrientes

---

## 🔧 Configuración Actual

### Servidor de Desarrollo
```bash
# Comando para iniciar servidor HTTP local
python -m http.server 8000

# Acceso desde PC
http://localhost:8000

# Acceso desde celular (misma red WiFi)
http://192.168.1.4:8000
```

### Estructura de Archivos
```
pagina-web-custom/
├── index.html          # Aplicación principal (31,652 bytes)
├── manifest.json       # Configuración PWA
├── service-worker.js   # Cache y funcionamiento offline
├── README.md          # Documentación completa
├── json/
│   └── nodes          # [ELIMINADO] Datos de prueba
└── .git/              # Control de versiones
```

---

## 🐛 Problemas Conocidos

### 1. Coordenadas GPS Incorrectas
**Síntoma**: Los dispositivos están en Corrientes pero el mapa los muestra en Chaco  
**Causa Probable**: 
- Datos de prueba ficticios con coordenadas de Resistencia, Chaco
- Posible inversión de latitud/longitud en datos del firmware
- Formato de coordenadas incorrecto (grados-minutos-segundos vs decimal)

**Solución Propuesta**:
- Verificar formato de datos que envía el dispositivo Meshtastic
- Comparar con servidor oficial de Meshtastic
- Ajustar código en línea 625 de `index.html` si es necesario

### 2. Corrupción del Archivo HTML al Editar
**Síntoma**: Al usar herramientas de edición automática, el archivo `index.html` se corrompe  
**Causa**: Problemas con encoding de caracteres especiales en las herramientas de edición  
**Solución Temporal**: `git restore index.html`  
**Solución Permanente**: Editar manualmente o usar editor de texto plano

### 3. Diseño Móvil - Telemetría Muy Grande
**Síntoma**: En móviles, los datos de telemetría se ven muy grandes y ocupan mucho espacio  
**Cambios Intentados** (no aplicados por corrupción de archivo):
```css
/* Cambios deseados pero no aplicados */
.telemetry-bar.collapsed { height: 40px; }  /* era 50px */
.telemetry-bar.expanded { height: 120px; } /* era 140px */
.telemetry-value { font-size: 14px; }      /* era 20px */
.telemetry-label { font-size: 9px; }       /* era 11px */
.telemetry-content { grid-template-columns: repeat(2, 1fr); } /* era auto-fit */
```

**Archivo Creado**: `mobile-fixes.css` (no enlazado en HTML, no tiene efecto)

---

## 📡 Integración con Firmware

### Endpoint Requerido
El firmware debe exponer: `GET /json/nodes`

### Formato de Datos Esperado
```json
{
  "data": {
    "nodes": [
      {
        "id": "!abc12345",
        "long_name": "Nombre del Dispositivo",
        "short_name": "ABCD",
        "position": {
          "latitude": -27.4689,    // Decimal, negativo para sur
          "longitude": -58.8344,   // Decimal, negativo para oeste
          "altitude": 65
        },
        "snr": 12.5,              // Opcional
        "battery": 92,            // Opcional (0-100)
        "last_heard": 1732831200  // Opcional (Unix timestamp)
      }
    ]
  },
  "status": "ok"
}
```

### Detección LoRa vs GSM
- Si `long_name` contiene "GSM" → Ícono rosa (GSM Bridge)
- Si no → Ícono morado (LoRa)

### Coordenadas para Corrientes, Argentina
```
Latitud:  -27.4689 (sur, negativo)
Longitud: -58.8344 (oeste, negativo)
```

---

## 🎯 Próximos Pasos

### Prioridad Alta:
1. **Optimizar diseño móvil**
   - Aplicar cambios CSS de forma manual
   - Reducir tamaños de fuente en telemetría
   - Cambiar grid a 2 columnas fijas

2. **Corregir coordenadas GPS**
   - Obtener datos reales del dispositivo Meshtastic
   - Verificar formato de coordenadas
   - Ajustar código si latitud/longitud están invertidas

3. **Testing con dispositivos reales**
   - Conectar dispositivos Heltec
   - Verificar endpoint `/json/nodes`
   - Validar visualización en mapa

### Prioridad Media:
4. Documentar proceso de instalación en Heltec
5. Configurar HTTPS para funciones avanzadas (Bluetooth, Geolocalización)
6. Optimizar actualización de datos (actualmente cada 10 segundos)

### Prioridad Baja:
7. Mejorar diseño de íconos en mapa
8. Agregar más opciones de exportación
9. Implementar filtros de nodos
10. Agregar gráficos de telemetría histórica

---

## 📝 Notas Técnicas

### Tecnologías Utilizadas
- **Frontend**: HTML5, CSS3, JavaScript ES6+
- **Mapa**: Leaflet.js 1.9.4 con OpenStreetMap
- **Almacenamiento**: IndexedDB para registro de eventos
- **APIs**: Web Bluetooth, Geolocation, Service Worker
- **Servidor Dev**: Python HTTP Server

### Configuración del Mapa
```javascript
// Línea 496 en index.html
const CONFIG = {
    mapCenter: [-27.4514, -58.9867],  // Centro inicial (Resistencia, Chaco)
    mapZoom: 6,
    refreshInterval: 10000,            // 10 segundos
    apiEndpoint: '/json/nodes'
};
```

### Funciones Clave
- `updateMap(nodes)` - Línea 607: Actualiza marcadores en mapa
- `updateTelemetry(nodes)` - Línea 651: Actualiza barra de telemetría
- `fetchNodes()` - Línea 583: Obtiene datos del endpoint
- `logSignalChange()` - Línea 812: Registra cambios LoRa↔GSM

---

## 🔗 Enlaces Importantes

- **Repositorio**: https://github.com/SrOtrebor/Rastreador-Hidrido-Web.git
- **Documentación Firmware**: Ver `prompt_para_firmware.md` (si existe)
- **README Completo**: `README.md` en raíz del proyecto

---

## 👥 Colaboración entre IAs

**Contexto para próxima IA**:
Este proyecto está siendo desarrollado con asistencia de múltiples IAs:
- Una IA trabajando en el firmware de los dispositivos Heltec
- Otra IA (yo) trabajando en la aplicación web
- Posiblemente otra IA continuará el desarrollo web

**Archivos de Contexto**:
- `DEVELOPMENT_LOG.md` (este archivo) - Estado general del proyecto
- `README.md` - Documentación de usuario
- `prompt_para_firmware.md` - Especificación para integración con firmware

**Recomendaciones**:
1. Leer este archivo completo antes de hacer cambios
2. Actualizar este log después de cambios significativos
3. Mantener el README.md sincronizado con funcionalidades
4. Usar `git restore` si el HTML se corrompe
5. Probar cambios en servidor local antes de commitear

---

**Última actualización**: 29 de Noviembre de 2025, 00:30 hs  
**Actualizado por**: Antigravity AI (Google Deepmind)
