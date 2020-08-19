# lightsail-k8s
LANGUAGES: English | Spànish
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
* The script uses the AWS cli to create the Lightsail instances, so you will need that installed and configured on your local machine. 
* Have exported KEY (pem file) and KEYPAIRCREATE (pub file) to access to instance

## Usage

* Clone this repo onto your local machine

        git clone https://github.com/brqx/lightsail-k8s

* Enter into the repo directory

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

==============================================================================================================================

# lightsail-k8s
Implementación de Kubernetes - Basado en Lightsail - 2020 Farmacia Zaragoza
Aprendizaje y reinvención en la nube de AWS - Brqx
-------------------------------------------------- ------------------------------------------
https://www.linkedin.com/in/brqxng/?locale=en_US
-------------------------------------------------- ------------------------------------------
Sitio - https://brqx.es/en
-------------------------------------------------- ------------------------------------------
Este proyecto es una bifurcación de:

https://github.com/mikegcoleman/lightsail-k8s/

Hemos cambiado y probado el código con la estructura actual y el estilo brqx.

Este es un conjunto simple de scripts para crear un clúster de Kubernetes en Lightsail.

# Requisitos previos

* Debe haber descargado la clave SSH predeterminada para sus instancias de Lightsail.
* Tener la configuración completa del archivo .aws / config
* El script utiliza la cli de AWS para crear las instancias de Lightsail, por lo que necesitará instalarlo y configurarlo en su máquina local. 
* Ha exportado KEY (archivo pem) y KEYPAIRCREATE (archivo pub) para acceder a la instancia

## Uso

* Clone este repositorio en su máquina local

        git clone https://github.com/brqx/lightsail-k8s

* Ingrese al directorio del repositorio

* Asegúrese de que todos los scripts sean ejecutables

        sudo chmod + x * .sh

* Crear estructura

        . ./create_cluster.sh
        
¿Por qué ejecutar un script con dot?

En nuestro método para administrar scripts de Unix definimos funciones.

Si ejecutamos un script con un punto, podríamos reutilizar estas funciones para probar el comportamiento de los scripts.

## Información

El script primero aprovisiona 1 instancia mediana de Lightsail para maestro ((4GB RAM 2 vCPU $ 20 al mes) y dos instancias micro / nano para trabajadores (1GB RAM 1 vCPU $ 10 cada / mes), como parte del proceso de aprovisionamiento, instala las últimas versiones de Docker, Kubectl, Kubeadm y Kubelet.

Luego instala Flannel para la red de pod.

Finalmente, usa Kubeadm para crear un nodo maestro, y una vez hecho esto, usa Kubeadm para agregar dos trabajadores.

Esta, por supuesto, no es una configuración lista para producción, pero está bien para poner algo en funcionamiento en la nube para experimentar.

Este script es completamente seguro para evitar desperdiciar dinero con las pruebas de AWS, una vez que se haya generado la estructura, esperará a que se presione la tecla para eliminar las instancias.

## Descripción real

Lo que hacemos en este script es lo siguiente:

1. Genera instancias
2. Crea un clúster de Kubernet
3. Agregar nodos
4. Mostrar información de clústeres y nodos

Este script se probó en agosto de 2020 con la última versión de kubectl (18) y ubuntu 16 image (blueprint)

## Información de archivo específica

create_cluster.sh -> Archivo principal

create_instances.sh -> Genera las tres instancias de Lightsail

run_cluster.sh -> Generar clúster de Kubernetes en instancias de Lightsail

delete_cluster.sh -> Eliminar instancias de Lightsail

install_prereqs_ubuntu.sh -> Script que actualizará las instancias de ubuntu a kubernetes necesarios

Nota: Tenemos un método para generar estos scripts preparando un número de pasos de depuración rápida para verificar problemas dentro de las instancias
