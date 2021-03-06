#!/bin/bash
ACTION=$1
COMPONENT=$2

USAGE() {
  case $1 in
  missing-arguments)
    echo "Missing Arguments"
    USAGE
    ;;
  Invalid-arguments)
    echo "Inavaid argumets"
    USAGE
    ;;
 Invalid-component)
      echo "Invalid Component Given, Must be one of the following !!"
      USAGE
      ;;
normal-user)
  echo " user don't have admin access"
  USAGE
  ;;
git-credentails)
  echo "git credentails are missing, export GIT_USERNAME and GIT_PASSWORD to the script"
  USAGE
  ;;
  *)
    echo -e "\e[33mUsage \e[35m$0 \e[31minstall \e[34mcart|catalogue|frontend|dispatch|payment|ratings|shipping|user|rabbitmq|mysql|redis|mongodb|\e[36mall(default)\e[0m"
exit 1
esac
}

if [ $# -lt 1 -o $# -gt 2 ]; then
  USAGE missing-arguments
  fi

  case $ACTION in
  install|all)
  :
  ;;
  *)
    USAGE "Invalid-arguments"
  esac

  if [[ -z "$COMPONENT" ]]; then

    WHICH_COMPONENT=all
    else
      case $COMPONENT in
      cart|catalogue|frontend|dispatch|payment|ratings|shipping|user|rabbitmq|mysql|redis|mongodb)
      WHICH_COMPONENT=$COMPONENT
      ;;
    *)
      USAGE Invalid-component
      ;;
    esac
    fi
ID_USER=$(id -u)
if [[ ${ID_USER} -ne 0 ]]; then
  USAGE normal-user
  fi

if [[ -z "${GIT_USERNAME}" || -z "${GIT_PASSWORD}" ]]; then
USAGE git-credentails
fi


case $ACTION in
install )
  if [[ "${WHICH_COMPONENT}" == "all" ]]; then
    for component in cart catalogue frontend dispatch payment ratings shipping user rabbitmq mysql redis mongodb; do
      sh components/${component}.sh
      STAT = $?
      if [[ $STAT -ne 0  ]]; then
        exit $STAT
        fi
      done
    else
  sh components/${COMPONENT}.sh
  fi
  ;;
  uninstall|reinstall)
  echo "under Developement"
;;
esac


