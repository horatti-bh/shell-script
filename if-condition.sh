#!/bin/bash
fit=$1

if [ -z "$fit" ]; then
  echo "usage: $0  Okay|something"
  exit 1
  fi


if [ "$fit" = "Okay" ]; then
  echo "I am fit accept the new challenges"

  fi


if [ $# -ne 3 ]; then
  echo "usage: $0 Okay|NotOkay yes no"
  exit 1
   fi

proccesor=$(ps -ef | grep java | grep -v grep | wc -l)

if [ "$proccesor" -gt 0 ]; then

  echo "check the proccess number Total = $proccesor "
  else
    echo "ssh is not running"


  fi

