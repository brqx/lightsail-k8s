#!/bin/bash 
# Farmacia Zaragoza 2020 - Kubernetes Learning
# v0.0.1 - 2020-08
#-----------------------------------------------------
# Defined functions
# get_ips - ssh_trip
# defining_variables - init_kubernetes - setting_structure - join_workers - cluster_running_test
#-----------------------------------------------------

#Useful functions
get_ips()
{
PRIV_IP_INSTANCE=$(aws lightsail get-instance --instance-name ${instance} --query 'instance.privateIpAddress' --output text )
PUB_IP_INSTANCE=$( aws lightsail get-instance --instance-name ${instance} --query 'instance.publicIpAddress'  --output text )
}

#---------------------------------------------------------------------------------

#Needed to have a clean connect
#Change to ssh_strip | ssh_strip_debug
ssh_strip_debug()
{
if [ "$1" != "" ] ; then
COMMAND="$*"
fi
echo "Comando pasado : $COMMAND"

ssh -q -o "StrictHostKeyChecking no" -i ${KEY} ${instance_user}@${TARGET} "${COMMAND}"
}	

#---------------------------------------------------------------------------------

#Change to ssh_strip | ssh_strip_clean
ssh_strip_clean()
{
if [ "$1" != "" ] ; then
COMMAND="$*"
fi

ssh -q -o "StrictHostKeyChecking no" -i ${KEY} ${instance_user}@${TARGET} "${COMMAND}" | tee output_ssh 2&> /dev/null 
}	

ssh_strip()
{
#ssh_strip_debug $*	
ssh_strip_clean $*
}	

#-----------------------------------------------------
# Kubernetes Structure	
# Functions redirect output to null. To debug change it
#-----------------------------------------------------

cluster_info()
{
echo "Getting cluster information                               "
echo "----------------------------------------------------------"

TARGET="${MASTER_PUB_IP}"	
ssh_strip "sudo kubectl cluster-info"
}

init_kubernetes()
{
echo "Initting Kubernetes (Master Node [etcd]) - Will delay two minutes"
echo "Master Public $MASTER_PUB_IP - Private $MASTER_PRIV_IP    "
echo "----------------------------------------------------------"

TARGET="${MASTER_PUB_IP}"
COMMAND="sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=${MASTER_PRIV_IP}"
ssh_strip 

echo "Kubernetes init succesfully"	
}	

#---------------------------------------------------------------------------------

setting_structure()
{
echo "Setting structure (Master Node) - Will delay two minutes"
echo "----------------------------------------------------------"
#Al poner $HOME entiende la carpeta actual desde la que se esta ejecutando el script

ssh_strip "mkdir -p /home/ubuntu/.kube"
ssh_strip "sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config"
ssh_strip "sudo chown 1000:1000 /home/ubuntu/.kube/config"

ssh_strip "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"

echo "Structure ready to use (kube-flannel applied)"	

}	

#---------------------------------------------------------------------------------

join_workers()
{

echo "Prepare JOIN command - Will delay two minutes             "
echo "----------------------------------------------------------"

JOIN=$(ssh -q -o "StrictHostKeyChecking no" -i $KEY ${instance_user}@${MASTER_PUB_IP} sudo kubeadm token create --print-join-command 2> /dev/null ) 

echo $JOIN

echo "Joining 1st worker (IP: " ${WORKER_1_PUB_IP} ")            "
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

TARGET=${WORKER_1_PUB_IP}
ssh_strip "sudo $JOIN"

echo "Joining 2nd worker (IP: " ${WORKER_2_PUB_IP} ")            "
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

TARGET=${WORKER_2_PUB_IP}

ssh_strip "sudo $JOIN"
	
}	

#---------------------------------------------------------------------------------

cluster_running_test()
{
echo "=========================================================="
echo "-        Cluster up and running                          -"
echo "----------------------------------------------------------"
TARGET=${MASTER_PUB_IP}
ssh_strip_debug "sudo kubectl get nodes"
echo "=========================================================="
}

#---------------------------------------------------------------------------------

defining_variables()
{
instance=kube-1
get_ips

MASTER_PUB_IP="${PUB_IP_INSTANCE}"
MASTER_PRIV_IP="${PRIV_IP_INSTANCE}"

instance=kube-2
get_ips
WORKER_1_PUB_IP="${PUB_IP_INSTANCE}"

instance=kube-3
get_ips
WORKER_2_PUB_IP="${PUB_IP_INSTANCE}"

#Instance user - In lightsail can be ubuntu - ec2-user - bitnami
instance_user="ubuntu"

export MASTER_PUB_IP MASTER_PRIV_IP WORKER_1_PUB_IP WORKER_2_PUB_IP
}

#---------------------------------------------------------------------------------
#Starting Program
#---------------------------------------------------------------------------------

#Key can be is passed as parameter
if [ "$1" != "" ] ; then
KEY=$1
fi

defining_variables

init_kubernetes

# Esto esta pendiente
#cluster_info

setting_structure

join_workers

sleep 30

cluster_running_test

#---------------------------------------------------------------------------------
