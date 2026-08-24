# Guía del instructor — proyecto de ejemplo

**Carpeta:** `ejemplo-mineria-conflicto/` · **Peso:** ~41 MB · 27 archivos

Este documento es para quien dicta, no para los participantes. Contiene el
solucionario de los ejercicios y lo que debería pasar en cada uno.

---

## 1. Qué es el proyecto

Un proyecto de investigación real, a medio empezar y deliberadamente desordenado,
sobre **minería y conflicto social en el Perú**. Sirve de espina dorsal a los
ejercicios de las dos sesiones.

**Pregunta de investigación:**

> En los departamentos mineros del Perú, ¿la renta minera reduce la conflictividad
> social — o solo cambia aquello por lo que se protesta?

Está diseñada para que **se rompa si le quitas uno de los dos tipos de dato**. La
primera mitad se responde con CSV; la segunda exige leer texto. Por eso funciona
con las cuatro disciplinas a la vez:

| Disciplina | Su versión de la pregunta | Dato que usa |
|---|---|---|
| Economía | ¿Correlaciona la intensidad minera con la frecuencia de conflictos? | Producción y empleo minero |
| Ciencia política | ¿Responde la agenda legislativa a los conflictos del terreno? | Proyectos de ley (JSON) |
| Sociología | ¿Qué actores aparecen y cómo cambia el repertorio? | Narrativas de la Defensoría |
| Antropología | ¿Se enmarca como agua y territorio, o como empleo y renta? | Narrativas de la Defensoría |

**El proyecto NO viene con `CLAUDE.md`.** Generarlo con `/init` es el ejercicio
del Bloque 5 de la Sesión 1.

---

## 2. Qué hay en la carpeta

### `datos/`

| Archivo | Qué es | Detalle |
|---|---|---|
| 10 PDF de la Defensoría | Reportes mensuales n.° 258–269 (ago 2025 – jul 2026) | 99–122 pp. c/u, con capa de texto |
| `produccion-minera-2025.zip` | Producción minera 2025 | 3 XLSX adentro |
| `produccion minera ene-may 2026.zip` | Producción ene–may 2026 | nombre con espacios, a propósito |
| `empleo_minero_2020_may2026.xlsx` | Empleo minero por departamento | 35 filas × 92 columnas, formato ancho |
| `mesas-dialogo.csv` | Mesas de diálogo monitoreadas (PCM) | 19 registros, 13 regiones |
| `compromisos-dialogo.csv` | Compromisos del Estado en mesas (PCM) | 506 registros, texto libre + estado |
| `proyectos-ley-mineria.json` | 251 proyectos de ley sobre minería y canon | API del Congreso |

**Faltan los reportes 261 y 263.** No es un descuido: la Defensoría no los publicó
con ninguna URL derivable. Si alguien lo nota, es un buen momento para hablar de
datos faltantes en fuentes oficiales.

### `papers/`

Ocho PDF con nombres deliberadamente caóticos (`descarga.pdf`,
`el pasado importa - copia (2).pdf`, `articulo minería (1).pdf`…). Materia prima
del ejercicio de renombrado.

**Tres de ellos no vienen al caso** (uno sobre Colombia, una reseña de economía,
un artículo metodológico). Es intencional: toda carpeta real tiene ruido, y
detectarlo es parte del ejercicio.

### Otros

- `bibliografia-borrador.md` — ★ el archivo con los errores sembrados (§4)
- `notas/ideas sueltas.md` — notas del "investigador"; incluye pistas sobre la
  decisión metodológica del canon y sobre la bibliografía sospechosa
- `descargar-datos.sh` — reproducibilidad; los datos ya vienen descargados

---

## 3. Trampas técnicas reales (úselas, no las evite)

Todas verificadas. Aparecen solas si alguien intenta automatizar:

1. **`wc -l` ≠ número de registros.** `compromisos-dialogo.csv` tiene 634 líneas
   pero **506 registros**: hay saltos de línea dentro de los campos de texto.
   Excelente para mostrar por qué contar líneas engaña.
2. **Codificación y separador.** Los CSV de la PCM van en **latin-1** con
   separador **`;`**. Abrirlos "normal" produce mojibake.
3. **Una errata del propio Estado.** La cabecera del CSV de mesas dice
   `ENTIDENTIDAD QUE PRESIDE EL ESPACIOAD`. Los datos oficiales también vienen
   sucios.
4. **`www.datosabiertos.gob.pe` exige el `www.`** — sin él no resuelve en DNS.
5. **Portales que rechazan scripts.** gob.pe devuelve HTTP 418 y la API del
   Congreso devuelve 403 si el User-Agent no parece navegador.
6. **Formato ancho.** El XLSX de empleo minero trae los meses en 92 columnas.
   Hay que reestructurarlo antes de analizar.

---

## 4. ★ Solucionario: los ocho errores de `bibliografia-borrador.md`

Todos son **reales y verificables contra Crossref**. El ejercicio es pedirle a
Claude que verifique cada cita; debería encontrarlos todos.

| # | Lo que dice el borrador | Lo que dice Crossref |
|---|---|---|
| 1 | Loayza, **Mier y Teran** & Rigolini (2016), *World Development* | Solo **Loayza y Rigolini**. Mier y Teran es autor del *working paper* de 2013 (IZA DP 7226), y desaparece en la publicada |
| 2 | Aragón & Rud, **"The Blessing of Natural Resources"** | El publicado se llama **"Natural Resources and Local Communities"**. "The Blessing…" es el título del documento de trabajo del BCRP (2009) |
| 3 | …en *AEJ: **Applied Economics*** | Es *AEJ: **Economic Policy*** |
| 4 | Aragón & Winkler, DOI `…resourpol.2023.**104612**` | Ese DOI **existe pero es otro artículo**: Zhang et al. (2024), "Resilient recovery strategies". El correcto es `104305` |
| 5 | Arellano-Yanguas, **"A Thoroughly Modern Resource Curse?"** en *JDS* 47(4) | El artículo publicado es **"Aggravating the Resource Curse"**. Ese título es el del IDS Working Paper 300 |
| 6 | **Dargent, P.** | Es **Eduardo** Dargent |
| 7 | Bebbington, **Bury, Humphreys Bebbington**, … | En *World Development* el orden es **Humphreys Bebbington, Bury** — posiciones 2 y 3 intercambiadas |
| 8 | Salas Carreño (**2016**), vol. 22(2) | Impreso en **2017**; online en dic-2016. El volumen 22(2) es de 2017, así que el borrador se contradice solo |

Hay además un noveno detalle, más suave: en la sección "Por revisar" aparece
**"Orihuela, O."** en la cita de *Fading local effects*. Es **José Carlos**
Orihuela. Y Crossref devuelve además un *Carlos Orihuela* (UNALM) que es **otra
persona** — buen ejemplo de desambiguación de autores.

**El más valioso es el #4.** Un DOI roto se detecta al primer clic; un DOI que
resuelve al artículo equivocado sobrevive a la revisión por pares. Es exactamente
el tipo de error que solo aparece si uno verifica de verdad.

**El prompt que lo destapa todo:**

```text
Verifica cada cita de bibliografia-borrador.md contra Crossref.
Para cada una dime qué dato no coincide y cuál es el correcto.
No me digas que está bien si no la pudiste comprobar.
```

---

## 5. ★ El ejercicio de auditoría de la codificación (Sesión 2)

El que traslada la lección del taller —memoria contra verificación— del terreno
de las citas al de los datos.

**Paso 1.** Claude extrae los casos de los reportes PDF a un CSV. En el reporte
n.° 268, el texto narra **103 casos** con los campos `Caso`, `Fecha de inicio`,
`Tipo`, `Ubicación`, `Descripción de caso` y actores.

**Paso 2.** Claude clasifica cada demanda en categorías (agua, tierra y
territorio, empleo local, renta y compensación, consulta previa, incumplimiento
de acuerdos).

**Paso 3 — el corazón.** Cada participante **lee 20 casos a mano** y compara con
la clasificación de Claude. ¿Cuántos están mal? Esa tasa de error es un dato del
proyecto, no una anécdota: si es del 15%, hay que decirlo en el paper.

**Paso 4 — validación con fuente. Aquí está la mejor sorpresa del ejercicio.**

Cifras oficiales del reporte n.° 268 (junio 2026), verificadas en el PDF:

| Cifra oficial | Valor |
|---|---|
| Conflictos registrados en el mes | **197** |
| Activos / latentes | 151 (76.6%) / 46 (23.4%) |
| En proceso de diálogo | 90 |
| Conflictos **socioambientales** | **96** |
| De ellos, **minería** | **61 casos = 63.5%** |
| Activos que **no registraron hechos** en el mes | **81** |

Serie mensual de socioambientales, jun-2025 a jun-2026:
`99, 100, 98, 98, 97, 99, 101, 99, 98, 98, 97, 98, 96`

**La extracción ingenua NO va a cuadrar, y eso es lo valioso.** Una extracción
directa de los campos `Tipo:` recupera ~103 casos y ~42 socioambientales, contra
**197 y 96** oficiales.

¿Por qué? Porque el reporte **narra en detalle solo los casos que tuvieron hechos
nuevos en el mes**; los otros 81 aparecen únicamente en las tablas agregadas. La
base construida a partir del texto cubre **poco más de la mitad del universo**.

Un participante que no valide se lleva una base sesgada —sobrerrepresenta los
conflictos activos y ruidosos— **y no lo sabe**. Ese sesgo, en un paper, es fatal.

::: NOTA PARA QUIEN DICTA
Deje que descubran la discrepancia solos. El momento en que alguien dice "me
salen 42 pero el PDF dice 96" es el punto más alto de la sesión. Recién ahí
explique de dónde viene la brecha.
:::

---

## 6. Decisiones metodológicas que conviene explicar en voz alta

**Por qué no usamos el canon minero.** Es la variable ideal, pero el MEF solo lo
expone en un frameset ASP.NET de los años 2000 con navegación por postback: no
hay forma de exportarlo programáticamente. Usamos **producción y empleo minero
como proxy**, que es defendible porque el canon *es* el 50% del impuesto a la
renta minera distribuido a las zonas productoras.

Vale la pena decirlo tal cual: la investigación real está llena de estas
sustituciones, y lo que distingue al buen trabajo no es evitarlas sino
**declararlas**. Está anotado en `notas/ideas sueltas.md`, donde los
participantes lo van a encontrar solos.

**Por qué no hay entrevistas.** Se buscó en Harvard Dataverse, QDR, Zenodo,
ICPSR, ALICIA y el repositorio de la PUCP: **no existen entrevistas de acceso
abierto sobre minería peruana**. Las narrativas de la Defensoría cumplen esa
función y son del tema exacto.

**Por qué no hay prensa.** El `robots.txt` de La República bloquea por nombre a
`ClaudeBot`, `anthropic-ai` y `GPTBot`; El Comercio prohíbe el rastreo de su
archivo histórico. Es el mejor ejemplo concreto de que **"público" no significa
"reutilizable"**, y conviene mostrarlo en pantalla.

**Sobre la API del Congreso.** Es pública y no pide autenticación, pero **no está
documentada ni licenciada**. Puede romperse sin aviso. Preséntela así.

---

## 7. Antes de la clase

- [ ] Verificar que la carpeta esté en la máquina de cada participante (o clonada
      del repo). **No dependa de descargarla en vivo.**
- [ ] Confirmar `python3` con `pypdf`, `pandas` y `openpyxl` instalados.
- [ ] Tener a mano una captura del resultado esperado de cada ejercicio, por si
      una demo falla.
- [ ] Recordar: los datos ya están descargados. `descargar-datos.sh` es para
      reproducibilidad, no para correrlo en clase.
