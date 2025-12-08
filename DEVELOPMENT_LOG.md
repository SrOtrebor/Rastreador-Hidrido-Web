# Log de Desarrollo - Rastreador GPS Híbrido

## Fecha: 28-30 de Noviembre de 2025

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
12. ✅ **Corrección de bugs críticos en `index.html` (Sintaxis y Duplicación)**
13. ✅ **Mejora en depuración de recepción Bluetooth**

### En Progreso:
- ⚠️ **Verificación de visualización de datos SMS**: El firmware ya envía los datos, se está depurando la recepción en la web.
- ⚠️ **Optimización diseño móvil**: Intentos de reducir tamaños de fuente en telemetría.

### Pendiente:
- ❌ Ajuste de coordenadas GPS (actualmente muestra ubicación incorrecta)
- ❌ Testing intensivo con dispositivos reales en campo

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
├── index.html          # Aplicación principal
├── manifest.json       # Configuración PWA
├── service-worker.js   # Cache y funcionamiento offline
├── README.md          # Documentación completa
├── json/
│   └── nodes          # [ELIMINADO] Datos de prueba
└── .git/              # Control de versiones
```

---

## 🐛 Problemas Conocidos y Soluciones Recientes

### 1. Corrupción del Archivo HTML (Solucionado)
**Síntoma**: El archivo `index.html` tenía código duplicado y errores de sintaxis masivos.
**Causa**: Error en herramientas de edición automática que insertaron código en lugar de reemplazarlo correctamente.
**Solución**: Se realizó una limpieza manual del archivo, eliminando bloques duplicados y cerrando correctamente las funciones JavaScript.

### 2. Coordenadas GPS Incorrectas
**Síntoma**: Los dispositivos están en Corrientes pero el mapa los muestra en Chaco  
**Causa Probable**: 
- Datos de prueba ficticios con coordenadas de Resistencia, Chaco
- Posible inversión de latitud/longitud en datos del firmware
- Formato de coordenadas incorrecto (grados-minutos-segundos vs decimal)

**Solución Propuesta**:
- Verificar formato de datos que envía el dispositivo Meshtastic
- Comparar con servidor oficial de Meshtastic
- Ajustar código en línea 625 de `index.html` si es necesario

### 3. Diseño Móvil - Telemetría Muy Grande
**Síntoma**: En móviles, los datos de telemetría se ven muy grandes y ocupan mucho espacio  
**Estado**: Pendiente de aplicar estilos CSS optimizados.

---

## 📡 Integración con Firmware

### Endpoint Requerido
El firmware debe exponer: `GET /json/nodes` o enviar datos vía Bluetooth Notify.

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

---

## 📝 Notas Técnicas (Actualización 30/11)

### Depuración Bluetooth
Se han añadido logs (`console.log`) en la función `handleJsonData` para capturar:
1. El string JSON crudo recibido.
2. El objeto parseado.
3. La estructura del objeto (si los nodos están en `payload.nodes`, `nodes`, o `data.nodes`).

Esto es crucial para entender por qué los datos SMS inyectados por el firmware no se estaban visualizando, a pesar de ser enviados.

---

## 🔗 Enlaces Importantes

- **Repositorio**: https://github.com/SrOtrebor/Rastreador-Hidrido-Web.git
- **Documentación Firmware**: Ver `prompt_para_firmware.md` (si existe)
- **README Completo**: `README.md` en raíz del proyecto

---

**Última actualización**: 30 de Noviembre de 2025, 03:30 hs  
**Actualizado por**: Antigravity AI (Google Deepmind)
