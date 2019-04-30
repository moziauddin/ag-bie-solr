#!/bin/sh -x
bail() {
  echo 1>&2 $*
  exit 1
}

echo "${datestamp}"
datestamp=`date +'%Y%m%d'`
echo "${datestamp}"

# Configuration
configDir="/data/processing/config"
workDir="/data/work/ANBG-LICH"
sourceDir="${workDir}/${datestamp}"
processDir="/data/processing/ANBG/NSL_Package_DwCA"
processCmd="./NSL_Package_DwCA_run.sh"
BNTi_server="lichen.biodiversity.org.au"
BNTi_URL="https://${BNTi_server}/nsl/services/export/taxonCsv"
dataSetID="anbg-lich"

# Clear work area
rm "${workDir}"/DwC/*
rm "${workDir}"/Processed/*

# get the BNTi (icn) CSV:
mkdir -p "${sourceDir}"

echo "Downloading BNTi names CSV from: ${BNTi_URL}"
curl -s "${BNTi_URL}" > "${sourceDir}"/nsl_dawr_bieexport.csv
ls -lahF "${sourceDir}"/nsl_dawr_bieexport.csv

# Convert TaxxaS tables into DwCA
cd "${processDir}" || bail "Uable to get to process directory ${processDir}"
${processCmd} --context_param "workDir=${workDir}" --context_param "dateStamp=${datestamp}" --context_param "configDir=${configDir}" --context_param "outputDir=${workDir}" --context_param "nslDataResourceUID=${dataSetID}"
if [ $? -ne 0 ]; then
 bail "Unable to process source files"
fi

echo "Processing Results"
wc -l "${workDir}"/DwC/*
