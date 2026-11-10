#!/bin/bash

check_ip_dns() {
    local host="$1"
    local expected_ip="$2"
    local dns_server="$3"

    local resolved_ip
    resolved_ip=$(nslookup "$host" "$dns_server" 2>/dev/null | awk '/^Name:/ {getline; print $2}')

    if [[ -n "$resolved_ip" && "$resolved_ip" == "$expected_ip" ]]; then
        printf "[OK]   %-25s -> %s (DNS: %s)\n" "$host" "$expected_ip" "$dns_server"
        return 0
    else
        printf "[FAIL] %-25s -> asteptat: %s, primit: %s (DNS: %s)\n" "$host" "$expected_ip" "${resolved_ip:-N/A}" "$dns_server"
        return 1
    fi
}

DNS_SERVER="8.8.8.8"

while read -r ip host extra; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue

    if [[ "$ip" =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]]; then
        check_ip_dns "$host" "$ip" "$DNS_SERVER"
    fi 
done < /etc/hosts
#ceaw.baMBOLINA
echo "salut sunt ale"
