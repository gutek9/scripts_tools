#!/bin/bash
function deploysecrets {
                f=$1
                ns=$( echo $f | cut -d "/" -f3 )
                pod=$( echo $f | cut -d "/" -f4 )
                sec=""        
                seclist=""

                for sec in $( find secrets/$ns/$pod/ -type f ); do
                        seclist="--from-file=$sec $seclist"
                done
                kubectl -n $ns create secret generic $pod $seclist
                RETURN=$?
        
                if [[ $RETURN -eq 1 ]]; then
                        kubectl -n $ns delete secret $pod
                        kubectl -n $ns create secret generic $pod $seclist
                else
                        echo "UNKNOWN ERROR DURING SECRETS APPLY. ERROR $RETURN"
                fi
}

#set -x

workspace=/tmp/provisioning
mani_repo="ssh://git@bitbucket.otlabs.fr/tk/nerf-k8s-objects.git"
oldlist=/tmp/oldlist
newlist=/tmp/newlist

# INITIAL LIST and CLONE
mkdir $workspace
git clone $mani_repo $workspace
cd $workspace
find ! -path "./.git*" -type f -exec md5sum "{}" + > $oldlist

while true; do
        git pull 

	find ! -path "./.git*" -type f -exec md5sum "{}" + > $newlist

        for el in $( comm -1 -3 <(sort /tmp/oldlist) <(sort /tmp/newlist) | cut -d " " -f3 ); do
                case "$el" in 
                        *namespaces*)
				echo $el 
				kubectl create -f $el 
				;;
                        *deployments*)
				echo $el 
				kubectl apply -f $el 
				;;
                        *secrets*) 
				echo $el
				deploysecrets $el 
				;;
			*)
				echo "Unhandled file $el"
				;;
                esac
        done

        cp $newlist $oldlist
        
        sleep 10
done
