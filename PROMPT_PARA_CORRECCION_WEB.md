# Prompt Detallado para Corrección de Interfaz Web (Bluetooth)

Por favor, utiliza la siguiente especificación técnica detallada para corregir y finalizar el archivo `index.html`. El objetivo es visualizar datos de nodos recibidos vía Bluetooth Low Energy (BLE) desde un dispositivo Heltec con firmware Meshtastic modificado.

## 1. Especificaciones de Conexión Bluetooth

### UUIDs de Servicio y Características
El dispositivo anuncia un servicio principal y varias características. La web debe buscar y conectarse a:

*   **Service UUID**: `6ba1b218-15a8-461f-9fa8-5dcae273eafd` (MESH_SERVICE_UUID)
*   **Characteristic UUID (Datos JSON)**: `e382570b-6072-4639-aa01-447551066804` (JSON_NODES_UUID)

### Flujo de Conexión
1.  El usuario hace clic en "Conectar Bluetooth".
2.  El navegador solicita dispositivo con filtro `{ namePrefix: 'Meshtastic' }` y servicio opcional `MESH_SERVICE_UUID`.
3.  Al conectar, obtener el servicio `MESH_SERVICE_UUID`.
4.  Obtener la característica `JSON_NODES_UUID`.
5.  **IMPORTANTE**: Iniciar notificaciones (`startNotifications()`) en esta característica.
6.  Escuchar el evento `characteristicvaluechanged` para recibir los datos.

## 2. Estructura Exacta de los Datos (JSON)

El firmware construye y envía un string JSON con la siguiente estructura exacta. **Nota**: El objeto raíz contiene `data` y `status`. La lista de nodos está dentro de `data.nodes`.

```json
{
  "data": {
    "nodes": [
      {
        "id": "!12345678",          // String: ID hexadecimal con '!' prefijo
        "snr": 10.5,                 // Number: Relación señal/ruido
        "last_heard": 1732948293,    // Number: Timestamp UNIX (segundos)
        "position": {
          "latitude": -27.123456,    // Number: Latitud decimal
          "longitude": -58.123456,   // Number: Longitud decimal
          "altitude": 100            // Number: Altitud en metros
        },
        "long_name": "Nombre Largo", // String: Nombre completo del nodo
        "short_name": "NM",          // String: Nombre corto
        "battery": 95                // Number: Nivel de batería % (Opcional)
      },
      // ... más nodos
    ]
  },
  "status": "ok"
}
```

### Puntos Críticos de Parsing
1.  **Estructura Anidada**: Los nodos NO están en la raíz. Se debe acceder a `objeto.data.nodes`.
2.  **Limpieza de String**: El string recibido puede contener bytes nulos (`\0`) al final. Es vital hacer `jsonString.replace(/\0/g, '')` antes de `JSON.parse()`.
3.  **Manejo de Errores**: Incluir bloques `try-catch` robustos alrededor del parsing, ya que un paquete corrupto no debe detener la aplicación.

## 3. Requerimientos de Visualización

### Diferenciación de Nodos (GSM vs LoRa)
El firmware inyecta nodos "virtuales" que representan reportes SMS. La web debe diferenciarlos visualmente.
*   **Criterio**: Si `node.long_name` contiene el string "GSM" o "SMS".
*   **Visualización**:
    *   **Icono en Mapa**: Usar un emoji de sobre (✉️) o icono distintivo en lugar del marcador estándar (📍).
    *   **Lista de Nodos**: Resaltar la tarjeta del nodo (ej. borde diferente, etiqueta "SMS/GSM").
    *   **Color**: Generar un color único basado en el `node.id` para mantener consistencia visual.

### Mapa (Leaflet.js)
*   Actualizar la posición de los marcadores existentes si el ID ya existe.
*   Crear nuevos marcadores si el ID es nuevo.
*   Mostrar popup con: Nombre, ID, Tipo (LoRa/GSM), SNR, Batería y Última vez visto.

### Lista de Nodos
*   Mostrar una tarjeta por cada nodo en la lista inferior.
*   Incluir todos los datos de telemetría disponibles.

### Exportación
*   Mantener la funcionalidad de guardar el historial de datos recibidos en `IndexedDB` para su posterior exportación a CSV/JSON.

## 4. Diagnóstico y Depuración
Para facilitar la corrección, el código debe incluir logs en consola (`console.log`) que muestren:
1.  El string JSON crudo recibido (`Raw JSON`).
2.  El objeto JSON parseado.
3.  Confirmación de si se encontró el array de nodos (`Found nodes in data.data.nodes`).

---

**Instrucción para el Desarrollador**:
Por favor, revisa el código de `connectBluetooth` y `handleJsonData` en `index.html` y asegúrate de que la lógica de navegación del objeto JSON coincida EXACTAMENTE con la estructura `data.data.nodes` descrita arriba. El error más probable actual es que el código busque `data.nodes` o `data.payload.nodes` incorrectamente.
