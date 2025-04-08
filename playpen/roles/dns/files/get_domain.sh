#!/bin/bash

# Function to sanitize strings for JSON output
sanitize_json() {
  local str="$1"
  echo "$str" | sed -e 's/"/\\"/g' -e 's/\//\\\//g'
}

json='{'
first_entry=true

# 1. Get the system's hostname and domain (if configured)
hostname=$(hostname -f)
if [ -n "$hostname" ]; then
  domain=$(hostname -d)
  if [ -n "$domain" ]; then
    if ! $first_entry; then json="${json},"; fi; first_entry=false
    json="${json}\"system_hostname\": \"$(sanitize_json "$hostname")\", \"system_domain\": \"$(sanitize_json "$domain")\""
  else
    if ! $first_entry; then json="${json},"; fi; first_entry=false
    json="${json}\"system_hostname\": \"$(sanitize_json "$hostname")\""
  fi
fi

json="${json}}"
