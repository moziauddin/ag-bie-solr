#!/bin/bash

set -e

green=`tput setaf 2`
reset=`tput sgr0`

ag_bie_scripts="Load_from_SFTP.sh Process_TaxxaS_Source_Data.sh Combine_Taxonomies.sh Import_Taxonomy.sh Swap_Cores.sh"

for script in ${ag_bie_scripts}
do
    echo "${green}${script}${reset}"
    ./${script}
    echo
done

exit 0
