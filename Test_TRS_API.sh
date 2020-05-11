#!/bin/sh -x
bail() {
  echo 1>&2 $*
  exit 1
}

datestamp=`date +'%Y%m%d'`
echo "${datestamp}"

# install dependecies
python -m pip install requests

# Run Test Python Script
chmod +x ./trs-api-tests.py
python ./trs-api-tests.py localhost