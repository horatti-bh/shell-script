#!/bin/bash

R="\e[2;31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

LOG_FILE=/tmp/RS.log
rm -rf $LOG_FILE

info() {
  echo -e "[${B}INFO${N}] $1"
}
STAT() {
  case $1 in
  0)
    echo -e "[${G}SUCCESS${N} $2 "
    ;;
  *)
    echo -e "[${R}ERROR${N} $2"
    echo -e "\e this is wrong please refer ${LIG_FILE}"
    exit 2
    ;;
    esac

#  if [ $? -eq 0 ]; then
#  echo SUCCESS
#  else
#    echo ERROR
#    fi
}
