## Script used to install ansible onto a Ubuntu Based System
# To Use: "wget https://raw.githubusercontent.com/capybarastone/ansible_deployment/refs/heads/main/mgmt_setup/install_ansible.bash", then "sudo bash install_ansible.bash"

# Install ansible onto mgmt system
sudo apt install sshpass python3-paramiko git
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
ansible --version

# Create Deployment User on mgmt
read -p "enter deployment user password: " Pass
hashPass=$(openssl passwd -1 $Pass)
sudo useradd -m deployment -p $hashPass -s /bin/bash
sudo usermod -aG sudo deployment

# Create SSH Keys for Deployment User on Mgmt
sudo mkdir -p /home/deployment/.ssh
sudo chmod 777 /home/deployment/.ssh
sudo chown -R deployment:deployment /home/deployment/.ssh
sudo -u deployment ssh-keygen -f /home/deployment/.ssh/deployment
sudo chmod 777 /home/deployment/.ssh/deployment
sudo chown -R deployment:deployment /home/deployment/.ssh

# Copy SSH Keys to Endpoint Devices (Assumes that deployment user is already added to end point systems)
sudo ssh-copy-id -i /home/deployment/.ssh/deployment.pub deployment@192.168.1.100
sudo ssh-copy-id -i /home/deployment/.ssh/deployment.pub deployment@192.168.1.101
sudo ssh-copy-id -i /home/deployment/.ssh/deployment.pub deployment@192.168.1.102

# Config SSH Agent
eval $(ssh-agent)
ssh-add -t 3h

# Download Deployment Inventory File
wget -O ~/ansible/inventory.yml https://raw.githubusercontent.com/capybarastone/ansible_deployment/refs/heads/main/mgmt_setup/inventory.yml


# Modify settings for ansible config
sudo cat >> ~/.ansible.cfg << EOF                                                               
[defaults]
host_key_checking = false
EOF
