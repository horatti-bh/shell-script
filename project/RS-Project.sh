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

  *)
    echo -e "\e[33mUsage \e[35m$0 \e[31minstall \e[34mcart|catalogue|frontend|dispatch|payment|ratings|shipping|user|rabbitMQ|mysql|redis|mongodb|\e[36mall(default)\e[0m"
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
      cart|catalogue|frontend|dispatch|payment|ratings|shipping|user|rabbitMQ|mysql|redis|mongodb)
      WHICH_COMPONENT=$COMPONENT
      ;;
    *)
      USAGE Invalid-component
      ;;
    esac
    fi

case $ACTION in
install )
  sh components/$COMPONENT.sh
  ;;
  uninstall|reinstall)
  echo "under Developement"
;;
esac


