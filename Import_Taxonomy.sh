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
workDir="/data/work/combined"
combined="${workDir}/combined"
importGroup=tomcat7
bieImportDir="/data/bie/import/combined"
bieIndexUrl="http://localhost:8080/ws"
bieIndexServer="`grep -E '^ *serverName *= *http[s]?://' /data/bie-index/config/bie-index-config.properties | sed -e 's/^.*\:\/\///g'`"

[ -d "${combined}" ] || bail "Cant find combined DwCA at ${combined}"

# Copy result to bie import area and make importable by tomcat7
[ -d "${bieImportDir}" ] && ( rm -rf "${bieImportDir}" || bail "Unable to delete ${bieImportDir}" )
cp -pr "${combined}"/* "${bieImportDir}" || bail "Unable to copy to ${bieImportDir}"
chgrp "${importGroup}" "${bieImportDir}" || bail "Unable to make ${bieImportDir} group ${importGroup}"
chmod g+w "${bieImportDir}" || bail "Unable to make ${bieImportDir} group writable"


# Trigger BIE import
result=`curl -X GET -f --header "Host: ${bieIndexServer}" "${bieIndexUrl}/admin/services/all"`
if [ $? -ne 0 ]; then
 bail "Unable to trigger import"
fi 
ok=`echo "$result" | jq .success`
if [ "$ok" != true ]; then
 bail "Import trigger failed"
fi
job=`echo "$result" | jq -r .id`
if [ -z "$job" ]; then
 bail "No job number"
fi
echo "Import job is ${job}"
count=100
while [ "$count" -gt 0 ]; do
 status=`curl -X GET -f --header "Host: ${bieIndexServer}" "${bieIndexUrl}/admin/services/status/$job"` || bail "Can't get job status"
 success=`echo "$status" | jq .success`
 active=`echo "$status" | jq .active`
 lifecycle=`echo "$status" | jq .lifecycle`
 message=`echo "$status" | jq .message`
 echo "Status active=${active} lifecycle=${lifecycle} success=${success} message=${message}"
 if [ "$active" != true ]; then
   if [ "$success" != true ]; then
     echo "Import failed!"sh """
                    cp -R code/api deploy/
                    cp docker/Dockerfile.dev deploy/
                    (cd deploy/api/<Name>.<Name>.Web/ && aws s3 cp --recursive --region=eu-west-1 s3://config.<name>/audience-view/atg/dev/API/ .)
                """
     exit 2
   fi
   echo "Import completed successfully"
   exit 0
 fi
 count=`expr $count - 1`
 sleep 60
done
echo "Timed out waiting for import to complete"
exit 3
