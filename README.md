### ag-bie-solr

These are the [ag-bie](https://ag-bie.oztaxa.com/) jobs to build the solr search index using jenkins jobs/scripts. 

**Description of Jobs:**

|Job Name|Descrption|
|-------|-----------|
|Load_from_SFTP.sh | Download the Taxonomy db from Taxa tree|
|Process_TaxxaS_Source_Data.sh | Pre-process Taxa tree db|
|Process_NSL_Source_Data_ICN.sh | Pre-process NXL ICN|
|Process_NSL_Source_Data_ICNP.sh | Pre-process NXL ICNP|
|Process_NSL_Source_Data_ICVCN.sh | Pre-process NXL ICVCN|
|Process_NSL_Source_Data_ICZN.sh | Pre-process NXL ICZN|
|Combine_Taxonomies.sh | Combine Taxanomies Stage|
|Import_Taxonomy.sh | Import into Solr|
|Swap_Cores.sh | Swap Solr Cores|
|run_all.sh | Runs all above scripts in proper sequence|

**Contact:**

Contact us using the Github contact...