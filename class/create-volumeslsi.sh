#!/usr/bin/env sh
STORCLI="/opt/MegaRAID/storcli/storcli64"
CONTROLLER="${1}"
ENCLOSURE="${2}"
SLOT_START="${3}"
SLOT_END="${4}"

for SLOT in `seq ${SLOT_START} ${SLOT_END}` ; do
  ${STORCLI} /c${CONTROLLER} add vd r0 Size=all drives=${ENCLOSURE}:${SLOT} nora wb
done
