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
workDir="/data/work/NSL"
sourceDir="${workDir}/${datestamp}"
processDir="/data/processing/NSL/NSL_Package_DwCA"
processCmd="./NSL_Package_DwCA_run.sh"
BNTi_URL="https://icn.oztaxa.com/nxl/services/export/taxonCsv"

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
${processCmd} --context_param "workDir=${workDir}" --context_param "dateStamp=${datestamp}" --context_param "configDir=${configDir}" --context_param "outputDir=${workDir}"
if [ $? -ne 0 ]; then
 bail "Unable to process source files"
fi

echo "Processing Results"
wc -l "${workDir}"/DwC/*
