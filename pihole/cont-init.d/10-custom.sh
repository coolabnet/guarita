#!/usr/bin/with-contenv bash
# shellcheck shell=bash

set -e

pihole -a -p "${WEBPASSWORD}" || true

# Add Whitelist
pihole --white-regex '(\.|^)whatsapp\.com$'
pihole --white-regex '(\.|^)whatsapp\.net$'
pihole --white-regex '(\.|^)fbcdn\.net$'
pihole --white-regex '(\.|^)wa\.me$'
pihole --white-regex '(\.|^)signal\.org$'
pihole --white-regex '(\.|^)whispersystems\.org$'
pihole --white-regex '(\.|^)souqcdn\.com$'

# Enable DHCP
pihole -a enabledhcp "10.0.0.1" "10.0.0.255" "10.0.0.1" "24" "peti"

while [ -z "$(ip -o -4 addr show dev "${INTERFACE}")" ]
do
   echo "Waiting for IPv4 address on ${INTERFACE}..."
   sleep 5
done
