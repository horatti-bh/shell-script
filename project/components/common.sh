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

