#!/bin/sh -x
bail() {
  echo 1>&2 $*
  exit 1
}

datestamp=`date +'%Y%m%d'`
echo "${datestamp}"

# Run Test Python Script
chmod +x ./trs-api-tests.py
python3 ./trs-api-tests.py localhost