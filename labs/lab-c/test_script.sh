#!/bin/bash

PROGRAM=main
TEST_DIR=test_hybrid
RESULTS_DIR=$TEST_DIR/results
INPUT_DIR=$TEST_DIR/input

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}[*] Compilando...${NC}"
gcc -g -o $PROGRAM main.c
if [ $? -ne 0 ]; then
    echo -e "${RED}[!] La compilación falló.${NC}"
    exit 1
fi

# Configuración
mkdir -p "$RESULTS_DIR" "$INPUT_DIR"
TOTAL_TESTS=0
PASSED_TESTS=0

# ========== Helper ==========
run_test() {
    local name=$1
    local input_file=$2
    local check_func=$3

    echo -e "${YELLOW}[*] Ejecutando prueba: $name${NC}"
    ./$PROGRAM < "$input_file" > "$RESULTS_DIR/${name}.out" 2>&1
    if $check_func "$RESULTS_DIR/${name}.out"; then
        echo -e "${GREEN}[+] PASS: $name${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}[!] FALLO: $name${NC}"
    fi
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
}

# ========== Test 1: Uso básico ==========
cat > "$INPUT_DIR/basic.txt" << EOF
1
First Note
This is the first note body.
1
Second Note
Body of second note.
2
0
2
1
3
0
6
EOF

check_basic() {
    grep -q "Nota añadida" "$1" && grep -q "Nota borrada" "$1"
}
run_test "uso_basico" "$INPUT_DIR/basic.txt" check_basic

# ========== Test 2: Entrada larga (Desbordamiento de buffer) ==========
LONG=$(head -c 400 < /dev/zero | tr '\0' 'A')
cat > "$INPUT_DIR/long_input.txt" << EOF
1
$LONG
$LONG
6
EOF

check_long_input() {
    grep -q "Nota añadida" "$1"
}
run_test "entrada_larga_desbordamiento" "$INPUT_DIR/long_input.txt" check_long_input

# ========== Test 3: Cadena de formato ==========
cat > "$INPUT_DIR/format.txt" << EOF
1
%x%x%x%x
body
2
0
6
EOF

check_format() {
    if grep -Eq '([0-9a-fA-F]{8,}|0x[0-9a-fA-F]{4,})' "$1"; then
        return 1
    fi
    return 0
}
run_test "cadena_formato" "$INPUT_DIR/format.txt" check_format

# ========== Test 4: Uso después de liberar memoria ==========
cat > "$INPUT_DIR/uaf.txt" << EOF
1
UAF title
UAF body
3
0
2
0
6
EOF

check_uaf() {
    grep -q "La nota fue eliminada" "$1"
}
run_test "uso_despues_de_libera_memoria" "$INPUT_DIR/uaf.txt" check_uaf

# ========== Test 5: Valgrind ==========
cat > "$INPUT_DIR/valgrind.txt" << EOF
1
Memory Leak?
This is a memory test
4
6
EOF

valgrind --leak-check=full --error-exitcode=1 ./$PROGRAM < "$INPUT_DIR/valgrind.txt" > /dev/null 2> "$RESULTS_DIR/valgrind.log"
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] PASS: Valgrind no muestra fugas de memoria${NC}"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}[!] FALLO: Se detectaron fugas de memoria${NC}"
fi
TOTAL_TESTS=$((TOTAL_TESTS + 1))

# ========== Resumen ==========
echo -e "\n${YELLOW}========== RESUMEN DE PRUEBAS ==========${NC}"
echo -e "${GREEN}Aprobadas: $PASSED_TESTS${NC} / ${YELLOW}Total: $TOTAL_TESTS${NC}"
SCORE=$((PASSED_TESTS * 100 / TOTAL_TESTS))
echo -e "${YELLOW}Puntaje final: ${SCORE}%${NC}"

# ========== Cleanup ==========
echo -e "\n${YELLOW}[*] Limpiando...${NC}"
rm -rf "$TEST_DIR" 
rm -f $PROGRAM notes.dat
