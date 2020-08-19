echo "00 " >  /tmp/run_script && apt-get install language-pack-es
echo "01 " >> /tmp/run_script && curl -sSL https://get.docker.com | sh 
echo "02 " >> /tmp/run_script && usermod -aG docker ubuntu
echo "03 " >> /tmp/run_script && apt-get update && apt-get install -y apt-transport-https curl
echo "04 " >> /tmp/run_script && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "05 " >> /tmp/run_script && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
echo "06 " >> /tmp/run_script && apt-get update
echo "07 " >> /tmp/run_script && apt-get install -y kubelet kubeadm kubectl
echo "08 " >> /tmp/run_script && apt-mark hold kubelet kubeadm kubectl
