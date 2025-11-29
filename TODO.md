# Lista de Tareas Pendientes

## 🔴 Urgente - Para Continuar Desarrollo

- [ ] **Optimizar diseño móvil de telemetría**
  - Reducir `font-size` de valores de 20px a 14px
  - Reducir `font-size` de etiquetas de 11px a 9px
  - Cambiar grid a 2 columnas fijas: `grid-template-columns: repeat(2, 1fr)`
  - Reducir altura colapsada de 50px a 40px
  - Reducir altura expandida de 140px a 120px
  - **Ubicación**: Líneas 93-152 en `index.html`
  - **Advertencia**: Editar manualmente, las herramientas automáticas corrompen el archivo

- [ ] **Corregir coordenadas GPS**
  - Obtener datos reales del endpoint del dispositivo Heltec
  - Verificar si latitud/longitud están en orden correcto
  - Verificar formato (decimal vs grados-minutos-segundos)
  - Ajustar línea 625 en `index.html` si es necesario
  - Coordenadas correctas para Corrientes: -27.4689, -58.8344

- [ ] **Integrar con firmware real**
  - Verificar que el dispositivo expone `/json/nodes`
  - Validar formato de datos según `prompt_para_firmware.md`
  - Probar conexión desde la web app

## 🟡 Importante - Mejoras de UX

- [ ] **Limpiar archivos no utilizados**
  - Eliminar `mobile-fixes.css` (no está enlazado)
  - Decidir si mantener o eliminar `json/nodes` de git

- [ ] **Mejorar feedback visual**
  - Agregar indicador de carga mientras se obtienen datos
  - Mostrar mensaje de error si falla la conexión
  - Agregar animación al actualizar marcadores

- [ ] **Optimizar para producción**
  - Configurar HTTPS en el dispositivo Heltec
  - Minificar CSS y JavaScript
  - Optimizar imágenes y recursos

## 🟢 Opcional - Funcionalidades Futuras

- [ ] **Gráficos de telemetría**
  - Agregar gráfico de SNR en el tiempo
  - Mostrar histórico de nivel de batería
  - Visualizar trayectoria del dispositivo

- [ ] **Filtros y búsqueda**
  - Filtrar nodos por tipo (LoRa/GSM)
  - Buscar nodos por nombre
  - Ocultar/mostrar nodos específicos

- [ ] **Notificaciones**
  - Alertas cuando batería < 20%
  - Notificación al cambiar LoRa↔GSM
  - Alerta si dispositivo pierde conexión

- [ ] **Mejoras de exportación**
  - Agregar formato Excel (XLSX)
  - Exportar solo rango de fechas
  - Incluir gráficos en exportación

## 📝 Notas

### Problema Conocido: Corrupción de HTML
Al editar `index.html` con herramientas automáticas, el archivo se corrompe.
**Solución**: Editar manualmente o usar `git restore index.html` para restaurar.

### Cambios CSS Deseados (No Aplicados)
Ver archivo `mobile-fixes.css` para referencia de los cambios que se intentaron aplicar.

---
**Última actualización**: 29/11/2025
