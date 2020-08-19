#! /bin/bash 
# Farmacia Zaragoza 2020 - Kubernetes Learning
# v0.0.1 - 2020-08
#-----------------------------------------------------

# We load functions to work

. ./create_instances.sh

# Wait for incences startup

echo "Waitting for instances be fully started"

sleep 100

. ./run_cluster.sh

# Wait for incences startup

read -rsp $'Press any key to delete cluster...\n' -n1 key

. ./delete_cluster.sh


