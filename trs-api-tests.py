'''
This script runs some API requests to check
the BIE index after it is built
Author: Mohammad Ziauddin

'''

import requests, json, sys

try:
    host = sys.argv[1]
    print("Host to Test:", sys.argv[1])
    search = 'search.json?'
    base_url = 'https://'+host+'/ws/'
    # print(base_url)

    # Count of Total Records
    url = base_url + search + 'q=*'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['searchResults']['totalRecords']
    print("Total Records: ", total_records)

    # Kingdom Count
    url = base_url + search + 'q=&fq=rank:%22kingdom%22'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['searchResults']['totalRecords']
    print("Number of \"Kingdom\" Records: ", total_records)

    # Total Taxon records
    url = base_url + search + 'q=*%3A*&fq=idxtype%3A"TAXON"'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['searchResults']['totalRecords']
    print("Number of \"taxon/species\" Records: ", total_records)

    # Lifeforms insects and spiders
    url = base_url + search + 'q=*%3A*&fq=speciesGroup:"Insects%20and%20Spiders"'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['searchResults']['totalRecords']
    print("Number of \"Insect/Spider\" Records: ", total_records)

    # Names in a lifeform Fungi
    url = base_url + search + 'q=*%3A*&fq=speciesGroup%3A"Fungi"'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['searchResults']['totalRecords']
    print("Number of \"Fungi Records\": ", total_records)

    # Names in a Accepted Names
    url = base_url + search + 'q=*%3A*&fq=taxonomicStatus%3A"accepted"'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['searchResults']['totalRecords']
    print("Number of \"Accepted Names\": ", total_records)

    # Search by scientific name
    url = base_url + search + 'q=*%3A*&fq=taxonomicStatus%3A"accepted"'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['searchResults']['totalRecords']
    print("Number of \"Accepted Names\": ", total_records)

    # Search with  wildcard
    url = base_url + search + 'q=aca*'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['searchResults']['totalRecords']
    print("Number of \"aca* wildcard\" Records: ", total_records)

    # Guid by name
    url = base_url + '/guid/Acacia dealbata'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr
    print("Number of \"GUID by NAME\" Records: ", len(total_records))

    # Search the auto-suggest
    url = base_url + 'search/auto?q=droso&limit=100#'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['autoCompleteList']
    print("Number of \"Autocomplete List\" Records: ", len(total_records))

    # Search taxon by id
    url = base_url + 'taxon/108576'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['taxonConcept']['nameComplete']
    print("Name Complete of the \"taxon by id\": ", total_records)

    # Search species by id
    url = base_url + 'species/B0B2B6D7-3BB6-4C00-8723-17CE9846BE3D'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr['taxonConcept']['nameComplete']
    print("Name Complete of the \"species by id\": ", total_records)

    # Get classsification by ID
    url = base_url + 'classification/103578'
    res = requests.get(url)
    sr = json.loads(res.content)
    total_records = sr
    print("Classification of Taxon: ", total_records)


    # Bulk Lookup by GUID
    url = base_url + 'species/guids/bulklookup'
    data = "[\"55003\",\"104007\",\"112030\",\"112031\"]"
    res = requests.post(url, data=data)
    sr = json.loads(res.content)
    total_records = sr['searchDTOList']
    print("Number of \"Bulk Lookup by GUID\" Records: ", len(total_records))

    # Bulk Lookup by String
    url = base_url + 'species/guids/bulklookup'
    data = "[\"Drosophila\",\"Acacia\",\"Bactrocera\",\"Microporus\",\"Tuberculatus\"]"
    res = requests.post(url, data=data)
    sr = json.loads(res.content)
    total_records = sr['searchDTOList']
    print("Number of \"Bulk Lookup by String\" Records: ", len(total_records))

except Exception as e:
    print("Error Details:", sys.exc_info())