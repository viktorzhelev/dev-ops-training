#!/bin/bash
    API_BASE="https://pricing.${REGION}.amazonaws.com"
    API1="$API_BASE/offers/v1.0/aws/AmazonRDS/current/region_index.json"
    curl ${API1} --output result.json
    result=$(cat result.json | jq -r ".regions."\"${REGION}\"".currentVersionUrl")  
  
    csv=${API_BASE}$result
    csv1="${csv%.*}".csv
    date=$(date '+%Y-%m-%d')
   echo $csv1
   echo $date
   echo $result
   echo $csv

    cd /

    mkdir -p  ~/aws-prices
    cd ~/aws-prices
    curl $csv1 | grep db.t3 >\<$date\>_rds.csv   
