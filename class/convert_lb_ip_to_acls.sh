#!/usr/bin/env bash
# Author Tekeem Buckridge
# Created 2019/03/27
#batch process comp netscaler xen_acls.yaml subnet ranges to cidr
#requires ipcalc http://jodies.de/ipcalc-archive/


ipcalcb=/opt/ipcalc-0.41/ipcalc
inputfile="$1"
outputfile="$2"
counter="$3"
stime="$(date '+ %s')"
if [[ ! -x $ipcalcb ]]; then
  #statements
  echo "FATAL: $ipcalcb does not exist or is not executeable exiting."
  exit 1
fi
if [[ -z $counter ]]; then
  #statements
  counter=1
fi
if [[ ! -r $inputfile ]]; then
  #statements
  echo "FATAL: the source file does not exist or is not readable exiting."
  exit 2
fi


if [[ -z $outputfile ]]; then
  #statements
  outputfile=/tmp/$(date '+ %s').iptables_acl.list
fi


for range in `awk '{ if (length($12) >= 8 ) print $12 }' $inputfile  |tr -d '",'` ; do
  #statements
  acl="$($ipcalcb -rn $range | tail -n +2)"
  printf "  - label: iaas-compute-onSL-%s\n" "$counter" >> $outputfile
  printf "    value: %s\n" "$acl" >> $outputfile
  ((counter++))
done

etime="$(date '+ %s')"
ftime=$(( etime - stime))

printf "output file was created at %s completed in %s seconds. \n" "$outputfile" "$ftime"
