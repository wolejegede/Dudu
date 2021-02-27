#!/usr/bin/env bash
# Created 2020/02/28
# Author tekeem.buckridge@ibm.com
# Description queries QRADAR to see if it contains logs for host
# Usage check_qradar.sh ossmlbdal0901b
QRADAR_HOST="http://scoccscandal1201a.softlayer.local"
QRADAR_PORT="5000"
tmpfile="/tmp/$(basename $0).data"
todays_date="$(date +'%b %d %Y')"
f_curl_post_data()
{
cat << EOF
fqdn=${1}
EOF
}
if [[ -e $tmpfile ]]; then
  #statements
  rm "$tmpfile"
fi
results="$(curl "${QRADAR_HOST}:${QRADAR_PORT}/results" -s -o "${tmpfile}" -w '%{http_code}' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Chrome/80.0.3987.122' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' -H 'Accept-Language: en-US,en;q=0.9' --data "$(f_curl_post_data ${1})" --compressed )"
if [[ $results -eq 200 ]]; then
  #statements
  log_date="$(grep -oE "([a-zA-Z]{3} [0-9]{2} [0-9]{4})" $tmpfile)"
  if [[ "$log_date" == "$todays_date" ]] && [[ $(grep -oE "${1}" "$tmpfile" ) == "${1}" ]]; then
    #statements
    printf "Found match for %s \n" "${1}"
    exit 0
  else
    printf "No logs Received in past 24 hours for ${1} \n"
    printf "Last log received was at %s %s \n" "$log_date" "$(grep -oE '(2[0-3]|[01]?[0-9]):([0-5]?[0-9]):([0-5]?[0-9])' $tmpfile)"
    exit 0
  fi
elif [[ $results -eq 404 ]]; then
  #statements
  printf "No Match found for %s \n" "${1}"
  printf "'%%' can be used to substitute any number of characters \n'-' can be used for a single character\n"
  exit 0
else
  printf "Error http code was %s \n" "${results}"
  exit 1
fi
