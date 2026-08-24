# Claude Code para investigación en ciencias sociales

**Taller para docentes — PUCP**
Alexander Quispe · Universidad del Pacífico

Este documento sirve para dos cosas: como guion de la sesión y como manual al que
volver después. Todo lo que aparece aquí fue probado en un caso real —preparar un
curso, descargar su bibliografía desde la biblioteca PUCP y auditar sus citas—, no
es una lista de funciones tomada de la documentación.

---

## 1. Qué es Claude Code, en una frase

Un agente que vive en tu terminal, ve tus archivos y puede ejecutar comandos por
ti. No es un chat al que le pegas texto: **trabaja dentro de tu computadora**.

Eso cambia lo que le puedes pedir. En lugar de "escríbeme un resumen de este
paper", le pides "lee los 40 PDF de esta carpeta, dime cuáles usan datos de panel
y arma una tabla". La diferencia no es de calidad de redacción: es que puede
abrir, contar, comparar y escribir archivos.

### Lo que hizo en el caso que voy a mostrarles

En una sesión de trabajo real, sobre un curso de teoría económica:

- Leyó el sílabo y verificó **cada cita** contra Crossref, NBER y arXiv.
  Encontró **cuatro citas equivocadas**, incluida una donde el título del paper
  no existía y otra donde faltaba un coautor.
- Descargó 28 papers, varios a través del proxy de la biblioteca PUCP.
- Escribió el sílabo en LaTeX, lo compiló y revisó el PDF resultante.
- Armó la página web del curso y la publicó.
- Creó las tareas semanales como *issues* de GitHub.

Nada de eso requiere saber programar. Sí requiere saber **qué pedirle y cómo
verificarlo**, que es de lo que trata este taller.

---

## 2. La idea central del taller

> **Lo más valioso que hizo el agente no fue escribir: fue encontrar errores.
> Y también los cometió.**

Las dos mitades importan igual.

**Encontró errores reales.** Un paper citado en el sílabo como *"Coding Beyond
Your Training"* resultó llamarse *"Agentic Delegation and the Language Frontier of
Software Developers"*, tener un coautor que no figuraba, y una muestra de 5 346
observaciones en lugar de 5 838. Nadie lo había notado.

**Cometió errores.** En ese mismo trabajo, el agente anotó un DOI inventado para
un artículo de *Management Science*. Se descubrió recién al intentar descargarlo:
la página daba error. El DOI correcto apareció consultando Crossref.

La conclusión práctica para investigadores: **el agente es excelente verificando
contra fuentes, y poco confiable recordando de memoria.** Todo lo que produzca de
memoria —una cita, una fecha, un número de página— hay que verificarlo. Todo lo
que verifique contra una fuente primaria, con el enlace a la vista, es sólido.

---

## 3. Antes de la sesión: qué instalar

Pídanles que lleguen con esto listo. Toma unos 30 minutos y es mejor no gastarlos
en clase.

| Herramienta | Para qué | Nota |
|---|---|---|
| **Claude Code** | El agente | Instrucciones en [docs.claude.com/claude-code](https://docs.claude.com/en/docs/claude-code) |
| **Git** | Control de versiones | En Mac viene con Xcode Command Line Tools |
| **Cuenta de GitHub** | Guardar y compartir trabajo | Con credenciales configuradas |
| **Visual Studio Code** | Editor | Opcional pero recomendado |
| **LaTeX** | Documentos y presentaciones | MiKTeX en Windows, MacTeX o Tectonic en Mac |
| **Python 3** | Scripts y análisis | Con `pypdf` o `pymupdf` para leer PDF |

**Sobre LaTeX:** hay dos caminos. MacTeX o MiKTeX instalan todo (varios GB).
[Tectonic](https://tectonic-typesetting.github.io/) es un binario único que
descarga cada paquete la primera vez que lo necesita. Si van a compilar poco,
Tectonic es mucho más liviano.

### Verificación en un solo paso

Que abran una terminal, escriban `claude` y le pidan literalmente esto:

> Revisa mi entorno: dime qué versión tengo de git, python y latex, si tengo
> credenciales de GitHub configuradas, y qué me falta instalar.

Es el primer ejercicio y a la vez el diagnóstico. Si algo falta, el agente
normalmente les dice cómo instalarlo.

---

## 4. Las reglas de seguridad, explicadas desde el inicio

Conviene decirlas al comenzar, porque si no la gente choca con ellas y cree que
la herramienta está rota.

### Nunca va a escribir tu contraseña

**Claude Code no ingresa contraseñas en formularios de login.** Ni la tuya, ni
ninguna. No importa que se la des, que lo autorices explícitamente, o que insistas:
es una restricción sin excepciones.

Tampoco crea cuentas, ni ingresa datos de tarjetas, ni resuelve CAPTCHAs.

**Esto no es un obstáculo, es un cambio de reparto de tareas.** El patrón correcto:

1. **Tú** te logueas en el navegador, una vez.
2. **El agente** trabaja sobre esa sesión ya abierta.

Funciona igual de bien y te toma treinta segundos. En el caso real, así se
descargaron seis papers de bases suscritas: el profesor se logueó, el agente hizo
el resto.

### Otras acciones que te va a preguntar antes de hacer

- Descargar archivos
- Aceptar términos y condiciones
- Enviar correos o mensajes
- Publicar contenido
- Borrar o sobrescribir cosas

Es sano. Cuando pregunte, lean qué está por hacer.

---

## 5. Acceso a la biblioteca PUCP

Esta es la parte que más les va a servir en el día a día, y la que descubrimos
probando.

### El punto de entrada

El proxy de la PUCP se llama **elogim**. La URL general es:

```
https://pucp.elogim.com/auth-meta/login.php?url=<URL DEL EDITOR>
```

Pegan cualquier dirección de una revista después de `url=` y, si la Universidad
tiene suscripción, entra con acceso institucional. El proxy reescribe el host a
`<recurso>.pucp.elogim.com`.

Ejemplo, para un artículo de JSTOR:

```
https://pucp.elogim.com/auth-meta/login.php?url=https://www.jstor.org/stable/2171832
```

### Tres cosas que cuestan un rato descubrir solo

**Tu cuenta personal no es el acceso institucional.** Si entran a JSTOR con su
usuario propio, verán "100 artículos gratis este mes" y solo podrán *leer en
pantalla*. El botón de descarga aparece únicamente bajo la sesión de la
Universidad. Es el error más común.

**La sesión va por cookie.** Cualquier herramienta de línea de comandos —`curl`,
`wget`, un script de Python— va a recibir la página de login, no el PDF. Tiene que
ser un navegador logueado. Si le piden al agente "descarga este paper" y usa
`curl`, va a fallar: díganle que use el navegador.

**Que el servidor responda no significa que haya suscripción.** Probando, el host
de INFORMS respondía perfectamente… y el artículo pedía "Request Access". La PUCP
no tiene *Management Science*. Verificar que la página carga no basta: hay que
llegar hasta el PDF.

### Qué hay, y con qué grado de certeza

Conviene distinguir dos niveles, porque es exactamente el error que el propio
taller enseña a evitar.

**Comprobado bajando el PDF completo** (agosto 2026): JSTOR, Science/AAAS,
Wiley, AEA (AER, JEL, AEJ).

**Aparece en el catálogo de la biblioteca**, sin comprobar hasta el PDF:
ACM Digital Library, ACS, AIP, American Physical Society, Annual Reviews,
APA PsycNet, Brill, Cambridge Core, De Gruyter, EBSCO, Edward Elgar,
ProQuest Ebook Central.

**El servidor del proxy responde**, que es la evidencia más débil de las tres:
Emerald, IEEE Xplore, Nature, PNAS, Project MUSE, SAGE, ScienceDirect, Springer,
Taylor & Francis, Scopus, Web of Science. Trátenlo como una lista de candidatos
a probar, no como suscripciones confirmadas.

**Comprobado que NO tenemos:** Management Science / INFORMS, y Oxford University
Press (o sea, no hay QJE ni Review of Economic Studies por esta vía).

### Cuando no hay acceso

Casi siempre existe una versión abierta:

- **NBER, SSRN, arXiv, RePEc** — versiones *working paper*
- **Repositorios institucionales** de los autores
- **Google Scholar** suele mostrar un enlace [PDF] a la derecha

Con una advertencia que no es menor: **el working paper no es el artículo
publicado**. En un caso encontramos que la versión de SSRN tenía un solo autor y
la publicada tenía dos, y otra donde el título había cambiado por completo. Si van
a citar, citen la publicada; si van a leer, sirve cualquiera —pero sepan cuál
están leyendo.

---

## 6. Ejercicios

Ordenados de menor a mayor. Cada uno con lo que hay que observar, que es más
importante que completarlo.

### Ejercicio 1 — Diagnóstico del entorno *(5 min)*

> Revisa mi entorno de trabajo y dime qué tengo instalado y qué me falta.

**Qué observar:** que el agente ejecuta comandos y les muestra qué hace. No les
está contestando de memoria: está mirando su máquina.

### Ejercicio 2 — Poner orden en una carpeta *(10 min)*

Que usen una carpeta real con PDF descargados y nombres inconsistentes.

> En esta carpeta hay PDF de artículos. Ábrelos, y renómbralos con el formato
> apellido-año-palabraclave.pdf. Antes de renombrar nada, muéstrame la lista de
> cambios que vas a hacer.

**Qué observar:** que pedir el plan antes de ejecutar es una buena costumbre. Y
que el agente lee el contenido del PDF, no adivina por el nombre.

### Ejercicio 3 — La trampa de la cita *(15 min)* ← el más importante

Primera parte, sin verificar:

> Dame la cita completa, en APA, del paper de Noy y Zhang sobre los efectos de
> ChatGPT en la productividad. Incluye volumen, número, páginas y DOI.

Segunda parte:

> Ahora verifica cada dato de esa cita contra Crossref y dime exactamente qué
> estaba mal.

**Qué observar:** es muy frecuente que algo no cuadre —un número de páginas, un
año, un DOI—. Y el mismo agente lo detecta cuando se le pide verificar. **Esa es la
lección central del taller:** no es que mienta, es que la memoria y la
verificación son dos modos distintos, y hay que pedir el segundo explícitamente.

### Ejercicio 4 — Descargar de la biblioteca *(15 min)*

Que se logueen primero en el navegador, en el portal de la biblioteca. Después:

> Estoy logueado en la biblioteca PUCP. Busca este artículo [DOI] y descárgalo a
> la carpeta papers/. Si no tenemos acceso, dime dónde más se puede conseguir.

**Qué observar:** el reparto de tareas —ellos autentican, el agente opera— y que
el agente reporta honestamente cuando no hay acceso, en vez de inventar.

### Ejercicio 5 — Un documento reproducible *(20 min)*

> Toma estos datos y hazme una tabla en LaTeX, compílala a PDF y muéstrame el
> resultado. Si algo no compila, arréglalo y vuelve a intentar.

**Qué observar:** el ciclo de escribir–compilar–revisar–corregir sin intervención.
Aquí es donde la herramienta se separa claramente de un chat.

### Ejercicio 6 — Git sin miedo *(20 min)*

> Crea un repositorio para este proyecto, haz el primer commit, crea una rama
> llamada analisis, y explícame en lenguaje simple qué acabas de hacer y por qué.

**Qué observar:** que se puede aprender Git *usándolo con un agente que explica*,
en lugar de leer un tutorial primero.

---

## 7. Cómo pedir las cosas

Cuatro hábitos que hacen casi toda la diferencia.

**Pide el plan antes de la acción.** "Antes de hacer nada, dime qué vas a hacer."
Especialmente si va a modificar o borrar archivos.

**Di dónde está la verdad.** "Verifica contra el PDF que está en esta carpeta",
"consulta Crossref", "revisa la página oficial". Un agente con fuente asignada es
mucho más confiable que uno respondiendo de memoria.

**Pide que muestre el trabajo.** "Muéstrame el comando que usaste", "pega el
fragmento del que sacaste eso". Verificable es mejor que correcto.

**Cuando se equivoque, díselo directo.** No hay que ser diplomático. "Eso está
mal, el año es 2025" es la corrección más eficiente.

---

## 8. Errores comunes en las primeras sesiones

**Tratarlo como buscador.** "¿Qué opinas de la teoría X?" desperdicia la
herramienta. Sirve para trabajar sobre *tus* archivos y *tus* datos.

**Aceptar la primera respuesta sin mirar.** Sobre todo con números, citas y
fechas.

**Pedir demasiado de golpe.** "Reorganiza todo mi proyecto" sale mal. "Renombra
estos 12 PDF según este criterio" sale bien. Tareas acotadas, verificables una a
una.

**No usar control de versiones.** Si el agente va a tocar archivos, que estén en
Git. Así cualquier cambio es reversible y se ve exactamente qué se modificó.

**Insistir con la contraseña.** No va a pasar. Loguéate tú.

---

## 9. Guion sugerido de la sesión

| Tiempo | Bloque |
|---|---|
| 0:00–0:10 | Qué es y qué no es. El caso real como demostración |
| 0:10–0:20 | Reglas de seguridad. Por qué no escribe contraseñas |
| 0:20–0:30 | Ejercicios 1 y 2: entorno y carpeta |
| 0:30–0:50 | **Ejercicio 3: la trampa de la cita.** El corazón del taller |
| 0:50–1:10 | Biblioteca PUCP: el proxy, y ejercicio 4 |
| 1:10–1:30 | Ejercicio 5 o 6, según el público |
| 1:30–1:45 | Cómo pedir las cosas, errores comunes, preguntas |

Si el tiempo se acorta, **el ejercicio 3 es el que no se puede saltar**. Todo lo
demás se aprende solo después; el hábito de verificar, no.

---

## 10. Para seguir después del taller

Que empiecen por una tarea real y pequeña de su propia investigación. Las que
mejor funcionan de entrada:

- Ordenar y renombrar una carpeta de PDF acumulados
- Verificar la bibliografía de un artículo en preparación
- Extraer una tabla de un PDF a CSV
- Convertir apuntes en un documento con formato
- Automatizar algo que hacen a mano cada semana

Lo que **no** conviene de entrada: pedirle que reescriba un capítulo entero, o
que analice datos cuya limpieza no pueden verificar.
