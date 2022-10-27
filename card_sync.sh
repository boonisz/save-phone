#!/bin/bash
set -e  # Exit if error


# This script synchronizes data from FTP into local folder:
# - remove file that do not exist anymore in the FTP (mirror -e)
#
# No modification will be done in the FTP.
#
# Configuration is gathered at the beginning of the script.


# =============================================================================
#                   Configuration
# =============================================================================
FTP_USER=card
FTP_PASS=card
FTP_IP=192.168.1.21
FTP_PORT=2121


DESTINATION=Card/ # Local folder where to save files

# List of folders to save
#   example:  LINK+=("/distant/dir" "dir2")
#             will saved FTP folder "/distant/dir" in local folder "$DESTINATION/dir2"

LINK=()
LINK+=("Download" "Download")







# =============================================================================
echo "Start synchronisation"
for ((i=0; i<${#LINK[@]}; i+=2)); do
  DISTANT_DIR=${LINK[i]}
  LOCAL_DIR=${LINK[i+1]}
  echo "############################## ${DISTANT_DIR} > ${LOCAL_DIR}"
  mkdir -p "${DESTINATION}/${LOCAL_DIR}/"

  lftp ftp://${FTP_USER}:${FTP_PASS}@${FTP_IP}:${FTP_PORT} -e "mirror -e -x .thumbnails -x "saved" \"${DISTANT_DIR}\" \"${DESTINATION}/${LOCAL_DIR}\" ; quit"
done



