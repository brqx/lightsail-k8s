# lightsail-k8s
Kubernetes implementation - Lightsail based - 2020 Farmacia Zaragoza

This project will be a fork of : 

https://github.com/mikegcoleman/lightsail-k8s/

but fully working and fully translated to spanish

Let's do it ...

This is a simple set of scripts to create a Kubernetes cluster on lightsail. 

# Prerequisites

* You need to have downloaded the default SSH key for your Lightsail instances.
* The script uses the AWS cli to create the Lightsail instances, so you will need that installed and configured on your local machine. The instances will be created in whatever is configured as the default region for the CLI

## Usage

* Clone this repo onto your local machine

        git clone https://github.com/brqx/lightsail-k8s

* Chage into the repo directory

* Make sure all the scripts are executable

        sudo chmod +x *.sh

* Create Instances to use 

        ./create_instances.sh /path/to/your/lightsail.pem
        
        ./run_cluster.sh

## Information

The script first  provisions 1 Lightsail medium instance (master) and two micro/nano instances for workers (1GB RAM 1 vCPU $10 each / month), as part of the provisioning process it installs the latest versions of Docker, Kubectl, Kubeadm, and Kubelet.

It then installs Flannel for the pod networking. 

Finally, it uses Kubeadm to create a master node, and after that's done it uses Kubeadm to add two workers. 

This is, of course, not a production-ready setup, but is fine to get something up and running in the cloud to being experimenting with. 

## Real description 

What we do in this script is the following : 

1. Generate instances
2. Create kubernet cluster
3. Add nodes

This script have been tested in 2020 August with the lates version of kubect ( 18 ) and ubuntu 16 image (blueprint)



