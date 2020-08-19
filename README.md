# lightsail-k8s
Kubernetes implementation - Lightsail based - 2020 Farmacia Zaragoza
AWS Cloud Learning and Reinventing - Brqx 
--------------------------------------------------------------------------------------------
https://www.linkedin.com/in/brqxng/?locale=en_US
--------------------------------------------------------------------------------------------
Site - https://brqx.es/en
--------------------------------------------------------------------------------------------
This project is a fork of : 

https://github.com/mikegcoleman/lightsail-k8s/

We have changed and tested code with current structure and brqx style.

This is a simple set of scripts to create a Kubernetes cluster on lightsail. 

# Prerequisites

* You need to have downloaded the default SSH key for your Lightsail instances.
* Have fully setting of .aws/config file
* The script uses the AWS cli to create the Lightsail instances, so you will need that installed and configured on your local machine. The instances will be created in whatever is configured as the default region for the CLI
* Have exported KEY (pem file) and KEYPAIRCREATE (pub file) to access to instance

## Usage

* Clone this repo onto your local machine

        git clone https://github.com/brqx/lightsail-k8s

* Chage into the repo directory

* Make sure all the scripts are executable

        sudo chmod +x *.sh

* Create structure

        . ./create_cluster.sh 
        
Why run script with dot ? 

In our method to manage unix scripting we define functions. 

If we run script with a dot, we could to reuse these functions to test scripts behaviour

## Information

The script first  provisions 1 Lightsail medium instance for master ((4GB RAM 2 vCPU $20 month) and two micro/nano instances for workers (1GB RAM 1 vCPU $10 each / month), as part of the provisioning process it installs the latest versions of Docker, Kubectl, Kubeadm, and Kubelet.

It then installs Flannel for the pod networking. 

Finally, it uses Kubeadm to create a master node, and after that's done it uses Kubeadm to add two workers. 

This is, of course, not a production-ready setup, but is fine to get something up and running in the cloud to being experimenting with. 

This script is fully sure to avoid to waste money with aws testing, once have generated structure will wait for keypressed to delete instances

## Real description 

What we do in this script is the following : 

1. Generate instances
2. Create kubernet cluster
3. Add nodes
4. Show Cluster and Nodes information

This script have been tested in 2020 August with the latest version of kubectl ( 18 ) and ubuntu 16 image (blueprint)

## Specific file information

create_cluster.sh         --> Main file

create_instances.sh       --> Generate the three lightsail instances

run_cluster.sh            --> Generate Kubernetes cluster in lightsail instances

delete_cluster.sh         --> Remove lightsail instances

install_prereqs_ubuntu.sh --> Script what will update ubuntu instances to kubernetes needed

Note: We have a method to generate these scripts preparing a fast debug step numbers to check problems inside instances


