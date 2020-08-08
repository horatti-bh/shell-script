#!/bin/bash


company=$1
case $company in
Product_based)

echo "will git good salary"
echo "less work"
;;

service_based)

echo "work more"
echo "shifts"
;;
*)
  echo "other companies i don't want"
  exit 1
esac