#!/bin/bash

./Load_from_SFTP.sh \
    && ./Process_TaxxaS_Source_Data.sh \
    && ./Combine_Taxonomies.sh \
    && ./Import_Taxonomy.sh \
    && ./Swap_Cores.sh
