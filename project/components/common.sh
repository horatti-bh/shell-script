#!/bin/bash

R="\e[2;31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

LOG_FILE=/tmp/RS.log
rm -rf $LOG_FILE

timeStump() {
  date +%F-%T
}
info() {
  echo -e "$(timeStump) [${B}INFO${N}] $1"
}
STAT() {
  case $1 in
  0)
    echo -e "$(timeStump) [${G}SUCCESS${N}] $2 "
    ;;
  *)
    echo -e "$(timeStump) [${R}ERROR${N}] $2"
    echo -e "This is wrong please refer the log file and fix it: ${LOG_FILE}"
    exit 2
    ;;
    esac
    }

  CLONE()  {
    COMPONENT=$1
    if [[ -d "/tmp/${COMPONENT}" ]]; then
      rm -rf /tmp/${COMPONENT}
      fi
    mkdir -p /tmp/${COMPONENT}
    git clone https://github.com/horatti-bh/${COMPONENT}.git /tmp/${COMPONENT}
   }


#  if [ $? -eq 0 ]; then
#  echo SUCCESS
#  else
#    echo ERROR
#    fi

