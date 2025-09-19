#!/bin/bash
# Curitiba 19 de Novembro de 2025...
# Editor: Jeverson D. Silva ///@JCGAMESCLASSICOS
# CORREÇÃO DE SISTEMA POR TEMPO...

# Definir variáveis
URL="https://github.com/JeversonDiasSilva/chars/releases/download/v1.0/load"
SQUASH=$(basename "$URL")
TEMP_DIR="/tmp/sys"
BACKUP_DIR="/usr/share/retroluxxo/scripts/bkp"
SCRIPT_PATH="/usr/share/retroluxxo/scripts/load.sh"

# Definir cores
ROXO='\033[1;35m'    # Roxo, negrito
VERDE='\033[1;32m'   # Verde, negrito
NENHUMA='\033[0m'    # Sem cor

# Exibir cabeçalho em caixa alta com cores
echo -e "${ROXO}CURITIBA 19 DE NOVEMBRO DE 2025...${NENHUMA}"
echo -e "${ROXO}EDITOR: JEVENSON D. SILVA ///@JCGAMESCLASSICOS${NENHUMA}"
echo -e "${VERDE}CORREÇÃO DE SISTEMA POR TEMPO...${NENHUMA}"
echo ""

# Criação do diretório de backup
mkdir -p "$BACKUP_DIR"

# Remover script antigo, se existir
if [ -f "$SCRIPT_PATH" ]; then
    rm -f "$SCRIPT_PATH"
fi

# Baixar o arquivo da URL (sem saída)
echo -e "${VERDE}BAIXANDO O ARQUIVO DE: HTTPS://**************"
wget "$URL" -O "/tmp/$SQUASH" &>/dev/null
if [ $? -ne 0 ]; then
    echo -e "${VERDE}ERRO AO BAIXAR O ARQUIVO $SQUASH!${NENHUMA}"
    exit 1
fi

# Descompactar o arquivo baixado (sem saída)
echo -e "${VERDE}DESCOMPACTANDO $SQUASH...${NENHUMA}"
unsquashfs -d "$TEMP_DIR" "/tmp/$SQUASH" &>/dev/null
if [ $? -ne 0 ]; then
    echo -e "${VERDE}ERRO AO DESCOMPACTAR O ARQUIVO $SQUASH!${NENHUMA}"
    rm -f "/tmp/$SQUASH"
    exit 1
fi

# Conceder permissões de execução
chmod -R 777 "$TEMP_DIR"
if [ $? -ne 0 ]; then
    echo -e "${VERDE}ERRO AO MUDAR PERMISSÕES DO DIRETÓRIO $TEMP_DIR!${NENHUMA}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Mover o script para o local correto
mv "$TEMP_DIR/load.sh" "$SCRIPT_PATH"
if [ $? -ne 0 ]; then
    echo -e "${VERDE}ERRO AO MOVER O SCRIPT PARA $SCRIPT_PATH!${NENHUMA}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Limpar arquivos temporários
rm -rf "$TEMP_DIR"
rm -f "/tmp/$SQUASH"
sleep 5
# Salvar a overlay
echo -e "${VERDE}SALVANDO OVERLAY...${NENHUMA}"
batocera-save-overlay 250
if [ $? -ne 0 ]; then
    echo -e "${VERDE}ERRO AO SALVAR O OVERLAY!${NENHUMA}"
    exit 1
fi

echo -e "${VERDE}PROCESSO CONCLUÍDO COM SUCESSO.${NENHUMA}"
