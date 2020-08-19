#!/bin/bash 
# Farmacia Zaragoza 2020 - Kubernetes Learning
# v0.0.1 - 2020-08
#-----------------------------------------------------

echo "Creating Lightsail instances (Ubuntu)"
echo "+++++++++++++++++++++++++++++++++++++"

#-Master (Need 2 cores) - medium_2_0

MASTER_BUNDLE="medium_2_0"

aws lightsail create-instances \
--instance-names kube-1 \
--availability-zone us-east-2a \
--blueprint-id ubuntu_16_04_2 \
--bundle-id ${MASTER_BUNDLE} \
--key-pair-name $KEYPAIRCREATE \
--output text \
--user-data "$(cat ./install_prereqs_ubuntu.sh)" | tr "\t" " " | grep OPERATIONS | cut -d " " -f 6-8


#-Workers (Micro/nano) instances

WORKERS_BUNDLE="medium_2_0"
#WORKERS_BUNDLE=nano_2_0

for i in `seq 2 3`; do 
aws lightsail create-instances \
--instance-names kube-$i \
--availability-zone us-east-2a \
--blueprint-id ubuntu_16_04_2 \
--bundle-id ${WORKERS_BUNDLE} \
--key-pair-name $KEYPAIRCREATE \
--output text \
--user-data "$(cat ./install_prereqs_ubuntu.sh)" | tr "\t" " " | grep OPERATIONS | cut -d " " -f 6-8
done

echo "+++++++++++++++++++++++++++++++++++++"


