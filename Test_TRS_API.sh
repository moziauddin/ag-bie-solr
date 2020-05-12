#!/bin/sh -x
bail() {
  echo 1>&2 $*
  exit 1
}

datestamp=`date +'%Y%m%d'`
echo "${datestamp}"

# Run Test Python Script
host=$(echo $JENKINS_URL | awk -F/ '{print $3}')
echo "Running tests on $host"

# Run Test Python Script
python3 ./trs-api-tests.py $host