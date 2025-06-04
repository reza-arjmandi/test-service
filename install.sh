#!/bin/bash
###########################################################
###################### VARIABLES ##########################
###########################################################

RED='\033[0;31m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NC='\033[0m'
GREEN='\033[0;32m'

###########################################################
################### EXECUTION START #######################
###########################################################

error() {
  printf " ${RED}==>${NC} $@\n"
}

info() {
  printf " ${CYAN}==>${NC} $@\n"
}

success() {
  printf " ${GREEN}==>${NC} $@\n"
}

abort() {
  error "$@"
  exit 1
}

execute() { 
  if ! $@ 
  then
      abort "$@"
  fi
}

create_dir() {
  if ! [ -d "$1" ]; then
      execute "sudo" "mkdir" "$1"
      info "Directory $1 created"
  else
      info "Directory $1 already exists"
  fi
}

###########################################################
################## EXECUTION INSTALL ######################
###########################################################

info "Starting the ${PURPLE}Insightful Agent${NC} installation v1.2.1"

### Make directory
directory="/usr/lib/Workpuls"
service_file="$directory/WorkpulsService"

create_dir $directory

info "Downloading service"
execute "sudo" "curl" "-L" "--progress-bar" "$base/WorkpulsService" "--output" "$service_file"
execute "sudo" "chown" "root:root" "$service_file"
execute "sudo" "chmod" "755" "$service_file"

info "Downloading config"
execute "sudo" "curl" "-L" "--progress-bar" "$base/config.json" "--output" "$directory/config.json"
execute "sudo" "sed" "-i" "" "-e" "s/organizationId/$organizationId/g" "$directory/config.json"
execute "sudo" "chmod" "744" "$directory/config.json"

info "Downloading service unit"
execute "sudo" "curl" "-L" "--progress-bar" "$base/com.Workpuls.service" "--output" "/lib/systemd/system/com.Workpuls.service"
execute "sudo" "chmod" "755" "/lib/systemd/system/com.Workpuls.service"

info "Downloaded successfully"

info "Enabling and starting service"
execute "sudo" "systemctl" "enable" "com.Workpuls.service"
execute "sudo" "systemctl" "start" "com.Workpuls.service"

success "The Agent has been installed succesfully!"
info "It might take up to 3 minutes for the Agent to finish configuration in the background."
