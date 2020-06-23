#!/bin/sh -x
bail() {
  echo 1>&2 $*
  exit 1
}

echo "${datestamp}"
datestamp=`date +'%Y%m%d'`
echo "${datestamp}"

# Configuration
username=dawr
configDir="/data/processing/config"
workDir="/data/work/TaxxaS"
sourceDir="${workDir}/${datestamp}"
credentials="${configDir}/.ssh/${username}.pem"
sftpServer="mgmt.oztaxa.com"

# Retrieve from server
[ -d "${sourceDir}" ] || mkdir -p "${sourceDir}" || bail "Unable to create source directory ${sourceDir}"
cd "${sourceDir}" || bail "Unable to access source directory ${sourceDir}"
rm -rf * || bail "Unable to clear source directory ${sourceDir}"
tblBiota="tblBiota_${datestamp}.csv"
sftp -oStrictHostKeyChecking=no -i "${credentials}" "${username}@${sftpServer}:${tblBiota}" || bail "Unable to retrieve ${tblBiota}"
tblBiotaAssociate="tblBiotaAssociate_${datestamp}.csv"
sftp -oStrictHostKeyChecking=no -i "${credentials}" "${username}@${sftpServer}:${tblBiotaAssociate}" || bail "Unable to retrieve ${tblBiotaAssociate}"
tblCommonName="tblCommonName_${datestamp}.csv"
sftp -oStrictHostKeyChecking=no -i "${credentials}" "${username}@${sftpServer}:${tblCommonName}" || bail "Unable to retrieve ${tblCommonName}"
