#!/usr/bin/env bash
# Descarga las fuentes del proyecto. Los datos YA vienen en datos/ — este script
# existe para que el proyecto sea reproducible y para actualizar la serie.
#
# Uso:  bash descargar-datos.sh
#
# Todas las URLs fueron verificadas con descarga real el 24 de agosto de 2026.
# Si algo falla, es porque la fuente cambió: revisar el portal correspondiente.

set -u
cd "$(dirname "$0")/datos" || exit 1

# Varios portales del Estado peruano rechazan clientes que no parecen navegador:
# gob.pe devuelve HTTP 418 y la API del Congreso devuelve 403 sin esto.
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0 Safari/537.36"

bajar() { # url destino
  if curl -sL -A "$UA" --max-time 120 -o "$2" "$1"; then
    printf "  %-52s %s\n" "$2" "$(du -h "$2" | cut -f1)"
  else
    printf "  %-52s FALLÓ\n" "$2"
  fi
  sleep 1
}

echo "== Defensoría del Pueblo — reportes mensuales de conflictos sociales =="
# Los nombres de archivo NO siguen un patrón: cambian de un mes a otro
# (N°, n.º, "VF", con y sin mes). Hay que sacarlos del portal, no adivinarlos:
#   https://www.defensoria.gob.pe/categorias_de_documentos/reportes/
# Nota: los reportes 261 y 263 no están publicados con ninguna URL derivable.
D="https://www.defensoria.gob.pe/wp-content/uploads"
bajar "$D/2025/09/Reporte-de-conflictos-sociales-n.º-258-–-agosto-2025.pdf"       "Reporte-de-conflictos-sociales-n.º-258-–-agosto-2025.pdf"
bajar "$D/2025/10/Reporte-de-Conflictos-Sociales-N°-259.pdf"                      "Reporte-de-Conflictos-Sociales-N°-259.pdf"
bajar "$D/2025/11/Reporte-Mensual-de-Conflictos-Sociales-N°-260-Oct_2025.pdf"     "Reporte-Mensual-de-Conflictos-Sociales-N°-260-Oct_2025.pdf"
bajar "$D/2026/01/Reporte-de-conflictos-sociales-n.º-262-–-diciembre-2025.pdf"    "Reporte-de-conflictos-sociales-n.º-262-–-diciembre-2025.pdf"
bajar "$D/2026/03/Reporte-de-Conflictos-Sociales-n-264-febrero-26.pdf"            "Reporte-de-Conflictos-Sociales-n-264-febrero-26.pdf"
bajar "$D/2026/04/Reporte-de-Conflictos-Sociales-n-265-VF.pdf"                    "Reporte-de-Conflictos-Sociales-n-265-VF.pdf"
bajar "$D/2026/05/Reporte-de-Conflictos-Sociales-n-266-VF.pdf"                    "Reporte-de-Conflictos-Sociales-n-266-VF.pdf"
bajar "$D/2026/06/Reporte-de-Conflictos-Sociales-n-267-VF.pdf"                    "Reporte-de-Conflictos-Sociales-n-267-VF.pdf"
bajar "$D/2026/07/Reporte-de-Conflictos-Sociales-n-268.pdf"                       "Reporte-de-Conflictos-Sociales-n-268.pdf"
bajar "$D/2026/08/Reporte-de-Conflictos-Sociales-n-269.pdf"                       "Reporte-de-Conflictos-Sociales-n-269.pdf"

echo "== MINEM — producción y empleo minero =="
# Portal: https://www.gob.pe/institucion/minem/colecciones/12125-estadisticas-mineras
C="https://cdn.www.gob.pe/uploads/document/file"
bajar "$C/7850353/5472883-2025%282%29.zip"           "produccion-minera-2025.zip"
bajar "$C/9679417/5472883-ene-may-2026.zip"          "produccion minera ene-may 2026.zip"
bajar "$C/6357723/4291678-empleo-2020-a-may-2026.xlsx" "empleo_minero_2020_may2026.xlsx"

echo "== PCM — mesas de diálogo y compromisos (datos abiertos) =="
# OJO: el dominio EXIGE el "www." — sin él no resuelve en DNS.
# Los CSV vienen con separador ";" y codificación latin-1.
P="https://www.datosabiertos.gob.pe/sites/default/files"
bajar "$P/Mesas%20de%20Dialogo%20Monitoreados_Jun2026.csv"                        "mesas-dialogo.csv"
bajar "$P/Compromisos%20Abiertos%20en%20Espacios%20de%20Dialogo_Jun2026.csv"      "compromisos-dialogo.csv"
bajar "$P/Formato_DiccionarioDatos%20SGSD%20Mesas%20de%20di%C3%A1logo.xlsx"       "diccionario-mesas-dialogo.xlsx"

echo "== Congreso — proyectos de ley sobre minería (API SPLey) =="
# API pública pero NO documentada ni licenciada oficialmente: puede romperse
# sin aviso. Rechaza User-Agent de scripts. Se consulta con cortesía (sleep).
API="https://api.congreso.gob.pe/spley-portal-service/proyecto-ley/lista-con-filtro"
tmp=$(mktemp -d)
i=0
for pal in mineria minera minero canon "concesion minera" socioambiental; do
  i=$((i + 1))
  curl -s -A "$UA" -X POST "$API" -H "Content-Type: application/json" \
    -d "{\"perParId\":2021,\"palabras\":\"$pal\",\"rowStart\":0,\"pageSize\":200}" \
    -o "$tmp/$i.json"
  sleep 1
done
python3 - "$tmp" <<'PY'
import json, glob, sys, os
vistos = {}
for f in sorted(glob.glob(os.path.join(sys.argv[1], "*.json"))):
    try:
        d = json.load(open(f))
    except Exception:
        continue
    for p in ((d.get("data") or {}).get("proyectos") or []):
        p.pop("rowsTotal", None)
        vistos[(p.get("perParId"), p.get("pleyNum"))] = p
out = sorted(vistos.values(), key=lambda p: (p.get("perParId") or 0, p.get("pleyNum") or 0))
doc = {
    "_fuente": "API SPLey del Congreso de la Republica del Peru",
    "_advertencia": "API publica pero NO documentada ni licenciada. Puede cambiar sin aviso.",
    "_endpoint": "https://api.congreso.gob.pe/spley-portal-service/proyecto-ley/lista-con-filtro",
    "_terminos_buscados": ["mineria", "minera", "minero", "canon", "concesion minera", "socioambiental"],
    "_periodo_parlamentario": "2021-2026",
    "total": len(out), "proyectos": out,
}
json.dump(doc, open("proyectos-ley-mineria.json", "w", encoding="utf-8"), ensure_ascii=False, indent=2)
print(f"  proyectos-ley-mineria.json                           {len(out)} proyectos")
PY
rm -rf "$tmp"

echo
echo "Listo. Fuentes NO incluidas y por qué:"
echo "  - Canon del MEF: solo exportable a mano desde apps5.mineco.gob.pe"
echo "  - INEI: el servidor rechaza conexiones automatizadas de forma intermitente"
