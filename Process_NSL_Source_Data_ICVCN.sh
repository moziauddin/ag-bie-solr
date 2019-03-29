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
workDir="/data/work/NSL-ICVCN"
sourceDir="${workDir}/${datestamp}"
processDir="/data/processing/NSL/NSL_Package_DwCA"
processCmd="./NSL_Package_DwCA_run.sh"
BNTi_server="icvcn.oztaxa.com"
BNTi_URL="https://${BNTi_server}/nxl/services/export/taxonCsv"
dataSetID="nsl-icvcn"

# Clear work area
rm "${workDir}"/DwC/*
rm "${workDir}"/Processed/*

# get the BNTi (icvcn) CSV:
mkdir -p "${sourceDir}"

echo "Downloading BNTi names CSV from: ${BNTi_URL}"
curl -s "${BNTi_URL}" > "${sourceDir}"/nsl_dawr_bieexport.csv
ls -lahF "${sourceDir}"/nsl_dawr_bieexport.csv

# Clean the IDs in the NSL CSV File
sed -i -E 's@(https?://[^,]+|(/[^,/]+)+)/([0-9]+)@\3@g' "${sourceDir}"/nsl_dawr_bieexport.csv
sed -ie 's/ICN/ICVCN/g' "${sourceDir}"/nsl_dawr_bieexport.csv

# Convert TaxxaS tables into DwCA
cd "${processDir}" || bail "Uable to get to process directory ${processDir}"
${processCmd} --context_param "workDir=${workDir}" --context_param "dateStamp=${datestamp}" --context_param "configDir=${configDir}" --context_param "outputDir=${workDir}" --context_param "nslDataResourceUID=${dataSetID}"
if [ $? -ne 0 ]; then
 bail "Unable to process source files"
fi

echo "Processing Results"
wc -l "${workDir}"/DwC/*
