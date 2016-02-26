#!/bin/bash
echo "Waiting elasticsearch to launch on 9200..."

while ! nc -z elasticsearch 9200; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done

urlencode() {
    # urlencode <string>

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%s' "$c" | xxd -p -c1 |
                   while read c; do printf '%%%s' "$c"; done ;;
        esac
    done
}


find /dashboards -name *.json -print0 | while read -d $'\0' dashboard
do
  dashboard_name=$(echo "$dashboard" | sed 's|/dashboards/\(.*\).json|\1|g')
  dashboard_url=$(urlencode "$dashboard_name")
  echo ""
  echo "Loading dashboard : $dashboard_name"
  curl -s -XPUT "http://elasticsearch:9200/kibana-int/dashboard/$dashboard_url" -d "@$dashboard"
done
