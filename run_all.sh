#!/bin/bash

set -e

ag_bie_scripts="Load_from_SFTP.sh Process_TaxxaS_Source_Data.sh Combine_Taxonomies.sh Import_Taxonomy.sh Swap_Cores.sh"

DATE_TBL_BIOTA_CSV=`date +'%Y%m%d'`
if [ -z "$1" ] ; then
    echo "No DATE_TBL_BIOTA_CSV supplied, using default (today's date)."
else
    DATE_TBL_BIOTA_CSV=${1}
fi

echo "DATE_TBL_BIOTA_CSV: ${DATE_TBL_BIOTA_CSV}"

for script in ${ag_bie_scripts}
do
    echo "RUNNING SCRIPT: ${script} ${DATE_TBL_BIOTA_CSV}"
    ./${script} ${DATE_TBL_BIOTA_CSV}
    echo
done

exit 0
