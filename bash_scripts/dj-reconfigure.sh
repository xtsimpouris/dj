#!/bin/bash

# Bach script that asks user to proceed to various changes to the system
LOGFILE="./dj-config.log"

echo "Script creates by Charalampos Tsimpouris, University of Patras"

usage() {
  echo "Availiable commands"
  echo "--locale    Reconfigure locale"
  echo "--timezone  Reconfigure timezone"
  echo "--network   Reconfigure network"
  
  echo "--all       All the above"
}

chk_root() {
  local meid=$(id -u)
  if [ $meid -ne 0 ];
    then
      echo "You must be root user to run this tool"
      exit 999
  fi
}

locale() {
  # Wheen ssh-ing from a pc with a locale that is not installed on domjudge,
  # ..errors how up. This will help the user to install more locales.
  chk_root
  dpkg-reconfigure locales
}

timezone() {
  # Change timezone to the one the user wants
  chk_root
  dpkg-reconfigure tzdata
}

if [ $# -eq 0 ]
  then
    usage
    exit 1
fi

if [ "$1" = "--locale" ]
  then
    locale
    exit 1
fi

if [ "$1" = "--timezone" ]
  then
    timezone
    exit 1
fi

if [ "$1" = "--all" ]
  then
    locale
    timezone
    exit 1
fi

