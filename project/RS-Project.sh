#!/bin/bash
ACTION=$1
COMPONENT=$2

USAGE() {
  case $1 in
  missing-arguments)
    echo "Missing Arguments"
    USAGE
    ;;
  *)
    echo -e "\e[33mUsage \e[35m$0 \e[31minstall \e[34mcart|catalogue|frontend|dispatch|payment|ratings|shipping|user|rabbitMQ|mysql|redis|mongodb|all(default)\e[0m"
esac
}

if [ $# -ne 2 ]; then
  USAGE missing-arguments
  fi