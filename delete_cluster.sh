#! /bin/bash 
#Delete instances used in kubernetes cluster

#alias awlddw="aws_deleteforce_and_wait_lightsail "
#aws_deleteforce_and_wait_lightsail kube-1 kube-2 kube-3

aws lightsail delete-instance --instance-name  kube-1  &> /dev/null
aws lightsail delete-instance --instance-name  kube-2  &> /dev/null
aws lightsail delete-instance --instance-name  kube-3  &> /dev/null

