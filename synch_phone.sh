#!/bin/env bash
set -e  # Exit if error


# This script synchronizes data from FTP into local folder:
# - remove file that do not exist anymore in the FTP (rsync --delete flag)
# - do not update file (a file that already existing locally will be ignore, rsync --ignore-existing flag))
#
# No modification will be done in the FTP, as the mount is done in read only mode.
#
# Configuration is gathered at the beginning of the script.


# =============================================================================
#                   Configuration
# =============================================================================
FTP_USER=ftp
FTP_PASS=ftp
FTP_IP=192.168.1.21
FTP_PORT=2121

SOURCE=tmp_phone-ftp/  # Temporary local folder, to mount FTP folder
DESTINATION=phone/ # Local folder where to save files


LINK=()
LINK+=("WhatsApp/Media/WhatsApp Video" "WhatsApp/WhatsApp Video")
LINK+=("WhatsApp/Media/WhatsApp Images" "WhatsApp/WhatsApp Images")
LINK+=("DCIM/Camera" "DCIM")

EXCLUDE_DIR=save

# =============================================================================



echo "========================================================================"
echo SOURCE: ${SOURCE}
echo DESTINATION: ${DESTINATION}
echo "========================================================================"
mkdir -p ${DESTINATION}


echo "Mount FTP folder in ${SOURCE} in read-only"
if [ ! -d ${SOURCE} ]; then
	mkdir -p ${SOURCE}
	curlftpfs -r ${FTP_USER}:${FTP_PASS}@${FTP_IP}:${FTP_PORT}/ ${SOURCE}
fi

echo curlftpfs -r ${FTP_USER}:${FTP_PASS}@${FTP_IP}:${FTP_PORT}/ ${SOURCE}
echo "Start synchronisation"
for ((i=0; i<${#LINK[@]}; i+=2)); do
  SOURCE_DIR=${LINK[i]}
  DESTINATION_DIR=${LINK[i+1]}
  echo "############################## ${SOURCE_DIR} > ${DESTINATION_DIR}"
  mkdir -p "${DESTINATION}/${DESTINATION_DIR}/"
  # WARNING with source, rsync do: copy folder with src but only folder content with src/
  rsync -rv --delete --ignore-existing --exclude "${EXCLUDE_DIR}" "${SOURCE}/${SOURCE_DIR}/" "${DESTINATION}/${DESTINATION_DIR}/"
done


# Wait that rsync free FTP mounted folder
sleep 1

echo "Remove mounted ${SOURCE}"
fusermount -u ${SOURCE}
rmdir ${SOURCE}
