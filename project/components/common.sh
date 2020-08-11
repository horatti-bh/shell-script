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
  echo -e "$(timeStump) [${B}INFO${N}] \t$1"
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
    git clone https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/horatti-bh/${COMPONENT}.git /tmp/${COMPONENT}
   }
   InstallNodeJS() {
     if [[ -e "/bin/node" ]]; then
       return 0
       fi
       URL=$(curl -s https://nodejs.org/en/download/ | xargs -n1 | grep linux-x64.tar | sed -e 's|=| |g' -e 's|>| |g'| xargs -n1 | grep ^http)
       FILENAME=$(echo $URL | awk -F / '{print $NF}')
       FOLDER_NAME=$(echo $FILENAME |sed -e 's/.tar.xz//')
curl -s -o /tmp/$FILENAME $URL
cd /opt
tar -xf /tmp/$FILENAME
mv $FOLDER_NAME nodejs
ln -s /opt/nodejs/bin/node /bin/node || true
ln -s /opt/nodejs/bin/npm /bin/npm  || true
ln -s /opt/nodejs/bin/npx /bin/npx || true
   }
createAppuser(){
  id $1 &>/dev/null
  if [[ $? -eq 0 ]]; then
    retrun 0
    fi
    useradd $1
}

#  if [ $? -eq 0 ]; then
#  echo SUCCESS
#  else
#    echo ERROR
#    fi

