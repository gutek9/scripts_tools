#!/bin/bash

export GREEN=`tput setaf 2`
export RED=`tput setaf 1`
export RESET=`tput sgr0`
export CONF_DIR="$HOME/kubectl"
export DOT_SHELL=".$( echo $SHELL | awk -F "/" '{print $NF}' )rc"
export RC_CONF=$(cat ~/$DOT_SHELL |  grep KUBECONFIG | grep -oe "[a-zA-Z0-9\_\-]*.conf")

function usage {
        echo -e "\nUsage: k8s [list|set|default]\n"
        echo "list      - list available configs"
        echo "set       - set config to be used in current session (using it's number, for example . k8s set 1)"
        echo "default   - set default config (using it's number, for example . k8s default 1)"
}

function get_k8s {
        NO=1
        export CURRENT_CONF=$(export | grep KUBECONFIG | grep -oe "[a-zA-Z0-9\_\-]*.conf")        
            
        echo -e "\nFound configs:\n"

        for CONF in $( ls $CONF_DIR ); do
                CONFS[$NO]=$CONF
                if [ "$CONF" == "$CURRENT_CONF" ]; then PRE="="; PRE2=">"; printf "${RED}"; fi
                if [ "$CONF" == "$RC_CONF" ]; then PRE2="*" ; printf "${GREEN}"; fi
                echo -e "\t$PRE$PRE2${RESET}\t ${CONFS[$NO]}"
                ((NO++))
                PRE=""
                PRE2=""
        done
        echo -e "\n"

        echo -e "#  => - current"
        echo -e "#  =* - current && default"
        echo -e "#   * - default"
}

function set_conf {
        export KUBECONFIG="$CONF_DIR/$1"
}

function set_default {
        sed -ie "s/$RC_CONF/$1/g" $HOME/$DOT_SHELL
        ERR=$?
        if [ $ERR -ne 0 ]; then echo "export KUBECONFIG=$CONF_DIR/$1" >> $HOME/$DOT_SHELL; fi
      
        source ~/$DOT_SHELL
}

case "$@" in 
        "list")
                get_k8s
                shift
                ;;

        "set"*)
                if [ -f $CONF_DIR/$2 ]; then
                        set_conf "$2"
                        shift
                else
                        echo "Provided config doesn't exist"
                fi
                ;;

        "default"*)
                if [ -f $CONF_DIR/$2 ]; then
                        set_default "$2"
                        shift
                else
                        echo "Provided config doesn't exist"
                fi
                ;;
         *)
                usage
esac

