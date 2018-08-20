#!/bin/sh -x
bail() {
  echo 1>&2 $*
  exit 1
}

hostname
/sbin/ifconfig

echo "${datestamp}"
datestamp=`date +'%Y%m%d'`
echo "${datestamp}"

# Configuration
configDir=/data/taxxas/config
workDir=/data/work/combined
taxxasDir="/data/work/taxxas"
nslDir="/data/work/nsl"
combineDir="/data/taxxas/ala-name-matching"
combineCmd="build-combined.sh"
combinedDir="${workDir}/combined_${datestamp}"
combined="${workDir}/combined"
archiveDir="/data/work/archive"

# Clear work area
rm "${combined}"/*

# Combine DwCAs
cd "${combineDir}" || bail "Uable to get to process directory ${combineDir}"
./build-combined.sh -c "${configDir}/taxxas-taxon-config.json" -w "${workDir}" -o "${combined}"  "${taxxasDir}/DwC/" "${nslDir}/DwC/"
#./build-combined.sh -c "${configDir}/taxxas-taxon-config.json" -w "${workDir}" -o "${combined}"  "${taxxasDir}/DwC/"
if [ $? -ne 0 ]; then
 bail "Unable to combine taxonomies"
fi

# Archive result
[ -d "${archiveDir}" ] || mkdir -p "${archiveDir}" || bail "Unable to create ${archiveDir}"
cd "${combined}" || bail "Unable to move to ${combined}"
zip "${archiveDir}/combined_${datestamp}.zip" *
