# Notas de las clases con RAs → mejoras para el taller de docentes

Fuente: transcripciones Whisper de las dos clases dictadas a los RAs del Q-LAB
(17–18 ago 2026, ~97 min + ~86 min). Los timestamps `[MM:SS]` refieren a
`transcripts/clase1-*.txt` y `clase2-*.txt` (locales, no versionados).
Audiencia nueva: profesores de la Facultad de Ciencias Sociales, 2 sesiones × 3 h,
**sin asumir terminal, Git ni markdown**.

---

## 1. El hallazgo estructural: calibración de tiempo

- El material del Día 1 se agotó en ~59 min de una clase planificada para 2 h
  (C1 [60:07] *"se me acabó… pensé que me iba a demorar más"*); los ~38 min
  restantes se improvisaron con material del Día 2 (MCPs).
- La Clase 2 terminó ~15 min antes (C2 [77:03]).
- **Implicación para docentes:** con público no técnico el ritmo será 2–3× más
  lento (instalación, terminal, conceptos nuevos). Para 3 h: planificar ~2 h de
  contenido nuclear + 45 min de ejercicios guiados + buffer. Cada bloque con un
  "corte natural" para poder extender o saltar sin improvisar.

## 2. Fricciones de arranque (primeros 15 min de C1)

Qué pasó: links que no cargaban [00:25–00:48], compartir pantalla dos veces
[00:56, 11:32], computadoras seteándose durante la clase [00:19], repo de demo
de 30 000 archivos que no terminaba de clonar y hubo que cambiar en vivo
[10:37–13:55] (confirmado por el feedback automático: *"elegiste un repo
demasiado grande para la demo"* C2 [64:14]).

**Para docentes:**
- Link único, corto y **en la pizarra/handout**, probado antes.
- Repo/carpeta de demo **pequeño y pre-clonado** (y una copia local por si no hay internet).
- Checklist AV de 5 min antes de empezar: pantalla compartida, zoom del terminal, fuente grande.

## 3. Confusión de productos — el bloque que más hay que cuidar

- Los propios RAs confundían Claude AI / Cowork / Code (C1 [03:20–03:25]);
  tú mismo anticipas: *"cuando ustedes ayuden a setear a los profes, quiero que
  les expliquen esto"* [03:05] y *"los profesores te van a decir: yo ya utilizo
  Claude, ¿para qué quiero que me instales cosas?"* [03:10].
- Las analogías familiares funcionaron muy bien en vivo y hay que conservarlas:
  la mamá diseñadora de modas con Cowork [04:24], el tío de mantenimiento de
  condominios que pasó de puros Excel a Cowork (C1 [76:50]).
- Restricción confirmada en clase: **Cowork exige suscripción ($20+); Claude
  Code corre con API** [04:52–05:15] — ya está en los slides de RAs; para
  docentes darle un slide propio con la decisión práctica ("¿qué compro yo?").

## 4. Terminal: mínimo indispensable + kit de rescate

- Lo que funcionó: reducir bash a **un solo comando** (`cd` + pegar ruta con
  *copy path* de VS Code) [14:44–15:38]; tip de *new terminal window* (y que a
  veces hay que abrir terminal dos veces para que aparezca) [11:57–12:52].
- ⚠️ Corregir en los slides nuevos: se dijo *"CD es de current directory"*
  [15:22] — es **change directory**. Menor, pero los docentes lo copiarán literal.
- Lo que faltó y se necesitó en vivo: un alumno quedó atrapado en la carpeta
  equivocada y hubo que rescatarlo con Ctrl+C ×2 dictado a viva voz [47:24–48:04].
  **Para docentes: slide "kit de rescate"**: <kbd>Esc</kbd> interrumpe,
  <kbd>Ctrl+C</kbd> ×2 sale de Claude, cómo volver (`claude --resume`, mostrado
  en [59:29]), y "si todo falla, cierra el terminal y abre otro".
- Momento didáctico que vale la pena replicar a propósito: no sabías ver
  archivos ocultos en Mac y **le preguntaste a Claude con un screenshot**
  (Cmd+Shift+. apareció al instante) [30:33–32:58]. Mensaje explícito para
  docentes: *"usa a Claude para resolver tus dudas sobre Claude y tu computadora"*.

## 5. Modelos y costos: dar UNA regla

El feedback automático lo marcó como contradictorio (C2 [64:27]): primero
"Sonnet es barato y bueno para código y les va a durar más" [19:18], luego
"yo casi no uso Sonnet, uso full Opus y Fable" [19:47].

**Para docentes, una sola regla accionable:** *trabajen todo con Opus; Fable
solo para redacción fina de papers (y sabiendo que se agota rápido); no toquen
el resto del menú.* Con la tabla de precios API al lado ($/M tokens) y el
recordatorio de `/model` para verificar qué está seleccionado [18:39–20:14].

## 6. Lo que funcionó y hay que conservar (núcleo pedagógico)

1. **`/init` sobre una carpeta real y desordenada** — la demo aterrizó bien y
   la instrucción "entren a su tesis, así esté sucia, no importa" conectó
   [28:03–28:27]. Para docentes: "traigan una carpeta real de su investigación".
2. **Jerarquía de memoria** explicada como usuario → proyecto → subcarpeta,
   con el ejemplo en vivo de crear `~/.claude/CLAUDE.md` ("siempre Python")
   [29:00–35:38]. Mantener el diagrama de cajas anidadas de los slides RAs.
3. **Plan mode con caso real** (revisar notebooks de un curso viejo)
   [40:00–46:36] — aunque hubo un tropiezo cambiando de modo con shift+tab
   [43:41–44:51]: **ensayar la secuencia de modos antes**, y en los slides
   docentes mostrar la barra inferior con captura ("así se ve cuando estás en
   plan mode").
4. **`/compact` con la analogía** "100 páginas → 10 que dicen lo mismo"
   [63:20–63:26] y el aviso de la esquina "a punto de llegar al límite" [63:56].
5. **El pipeline Whisper → Claude fue el momento wow de la Clase 2**: 97 min de
   video transcritos en 90 segundos [52:49–53:01] y Claude criticando tu propia
   clase en vivo [63:45–65:00]. Es LA demo de cierre para docentes: "graben sus
   clases/seminarios y conviértanlos en material de trabajo". Antes de correr,
   enseñaste a preguntarle a Claude por las specs de la máquina (GPU/CPU/RAM)
   [46:18–47:16] — conservar ese paso. (Precisión menor: los Apple Silicon sí
   tienen GPU integrada; evitar el "las Mac no tienen GPU, tienen núcleos"
   [52:18].) Para Windows: faster-whisper [66:47].
6. **Dashboard con el skill de dataviz** sobre data real de una tesis
   [28:26–30:14, 54:00] y compartirlo por link. Recordar el paso que falló en
   vivo: hay que poner *share → anyone with the link* antes de mandarlo
   [54:51–55:10].
7. **"PowerPoint no tiene código; LaTeX es código"** [84:21–84:35] — argumento
   central para docentes, con la demo de Beamer ≤15 slides para Tesis 1
   [74:15–74:52]. Requiere pedir instalación de LaTeX ANTES (te lo recordaste a
   ti mismo en [37:44]); el README del taller ya lo resuelve con MiKTeX/Tectonic.
8. **El framing "ustedes son jefes de investigación con asistentes"** — abrir
   una sesión por tarea (literatura / data / escritura) repartiéndolas como a
   asistentes [15:08–15:31]. Excelente metáfora para profesores que dirigen tesis.

## 7. `/deep-research`: precisiones para la nueva clase

- En clase se llamó "Deep Search" todo el tiempo y el primer intento **falló
  porque se pidió en prosa**: *"¿cómo que no hiciste DeepSearch?… es un
  workflow, no un comando"* (C2 [10:28–11:16]). En los slides docentes: el
  comando exacto es **`/deep-research <pregunta>`** con slash, y ya está
  correcto en el deck de RAs.
- La explicación del mecanismo (fan-out → fetch → votación → reporte) aterrizó
  bien [06:59–07:55]; la corrida real tomó 15–20 min y lo manejaste alternando
  tareas — para docentes: **lanzarlo al inicio del bloque** y revisar el
  resultado al final (enseña además que corre en background).
- El pedido que conviene enseñar como receta: *"usa deep-research + créame una
  carpeta y descárgame los papers relacionados"* [08:29–09:05] — los papers
  quedaron organizados por bloques temáticos y citables [56:30–58:00].
- Pregunta de alumno que los docentes repetirán: "baja working papers, ¿y los
  publicados?" [58:09]. La respuesta correcta para PUCP es el **proxy de la
  biblioteca (elogim)** — ya documentado con detalle en `profesores/README.md`
  §5. Evitar la tangente de Anna's Archive que salió en clase [58:52–60:04]
  (el propio Claude la marcó como infracción de copyright).
- Límite que tú mismo señalaste y que importa MUCHO en CC.SS.: para **libros**
  (antropología, sociología) ayuda poco [60:26–60:39]. Decirlo de frente y
  conectar con la biblioteca.

## 8. Plan B para demos que dependen de internet

La página del INEI/ENAHO se cayó en plena demo y arrastró todos los intentos
(web directa, librería R, paquete Python — todo dependía del mismo sitio)
[16:33–27:03]; se salvó usando la data limpia de la alumna ya clonada. Además
hubo un "AP error" de Claude con ~6 min muertos [77:23–79:45], y Ctrl+B
(background) había cambiado de versión desde la última vez que lo usaste
[81:15–81:52].

**Regla para el taller:** cada demo tiene (a) los insumos ya descargados en
local, (b) una captura o clip corto del resultado esperado como respaldo, y
(c) nada esencial depende de una web externa en vivo. Y asumir que la
herramienta cambia rápido: enseñar principios (los slides) y verificar
comandos la víspera.

## 9. Qué NO enseñar a los docentes (decisiones tomadas en audio)

- **GitHub MCP / pull requests / issues**: tu propia duda en vivo — *"esta
  parte no estoy seguro de enseñarles a los profes porque tendrían que saber
  qué es GitHub"* (C1 [86:03]). Además el merge fue bloqueado por los guardrails
  y consumió ~10 min de fricción [82:47–88:53]. Fuera de la sesión docente;
  los RAs pueden dar soporte con Git después.
- **Multiagentes/subagentes custom**: solo mencionar que ocurre solo [96:49].
- **`--dangerously-skip-permissions`**: contarlo como anécdota de riesgo
  (la historia del amigo al que "le tocó archivos" [57:41–57:57]) pero no
  enseñarlo como práctica.
- **WhatsApp MCP**: anécdota simpática [67:15–68:13], no ejercicio.

## 10. Esqueleto sugerido para las 2 sesiones docentes (3 h c/u)

Cruza lo que funcionó con los RAs con el guion de `profesores/README.md`:

**Sesión 1 — Confianza y verificación (3 h)**
1. Qué es y qué no es: AI / Cowork / Code + precios, con las analogías familiares (30')
2. Reglas de seguridad: contraseñas, permisos, el patrón "tú te logueas, él trabaja" (20')
3. Setup verificado con el ejercicio-diagnóstico del README ("revisa mi entorno") (30')
4. Terminal mínimo: cd + copy path + kit de rescate + `/init` sobre carpeta real (45')
5. **La trampa de la cita** (ejercicio 3 del README — el corazón) (30')
6. Biblioteca PUCP: proxy elogim + descargar un paper real (25')

**Sesión 2 — El flujo de investigación (3 h)**
1. Recap + plan mode con un caso real (30')
2. `/deep-research` lanzado al inicio, explicado mientras corre (30')
3. Data local → dashboard compartible (40')
4. Revisión de literatura → LaTeX → Beamer compilado (40')
5. Whisper: transcribir una clase/seminario y pedir feedback (el momento wow) (30')
6. Cómo pedir las cosas + errores comunes + siguientes pasos (README §7–8) (20')

## 11. Erratas puntuales a corregir al construir los slides docentes

| En clase se dijo | Debe decir |
|---|---|
| "CD es current directory" [C1 15:22] | `cd` = **change directory** |
| "Deep Search" (a secas) | `/deep-research` (comando slash) |
| Sonnet barato/dura más *y también* "solo uso Opus/Fable" | Una regla: Opus para todo; Fable solo redacción fina |
| "las Mac no tienen GPU, tienen núcleos/MCM" [C2 52:18] | Apple Silicon trae GPU integrada (framework MLX la usa) |
| Anna's Archive como vía de papers [C2 58:52] | Proxy biblioteca PUCP (elogim) + versiones abiertas (NBER/SSRN/arXiv) |
