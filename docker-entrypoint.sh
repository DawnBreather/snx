#!/bin/bash

set -e

echo "[INFO] Printing input parameters"
echo -e "\tHOSTNAME:\t{ ${HOST} }"
echo -e "\tUSERNAME:\t{ ${USER} }"
echo -e "\tPASSWORD:\t{ ${PASS} }"
echo -e "\tENVIRONMENT:\t{ ${ENV} }"

echo -e "\n\n[INFO] Installing appropriate snx version"
./${ENV}.snx_install.sh

echo -e "\n\n[INFO] Establishing VPN connectivity"
echo -e "${PASS}\ny" | snx -s ${HOST} -u ${USER} -g
snx_logs_path="/proc/$(pgrep snx)"
[[ -d ${snx_logs_path} ]] && tail -f ${snx_logs_path}/fd/3
