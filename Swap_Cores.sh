#!/bin/sh -x
bail() {
  echo 1>&2 $*
  exit 1
}

echo "${datestamp}"
datestamp=`date +'%Y%m%d'`
echo "${datestamp}"

# Configuration
solrUrl="http://localhost:8080/solr"
core1=bie
core2=bie-offline

# Swap cores
curl -X GET -f "${solrUrl}/admin/cores?action=SWAP&core=${core1}&other=${core2}" || bail "Unable to swap cores"
