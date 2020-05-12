#!/bin/bash

set -e

ag_bie_scripts="Load_from_SFTP.sh Process_TaxxaS_Source_Data.sh Combine_Taxonomies.sh Import_Taxonomy.sh Swap_Cores.sh Test_TRS_API.sh"

for script in ${ag_bie_scripts}
do
    echo "RUNNING SCRIPT: ${script}"
    ./${script}
    echo
done

exit 0
