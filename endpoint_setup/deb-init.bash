## Script used to intitialize test environment setup on windows
# To Use: "wget https://raw.githubusercontent.com/capybarastone/ansible_deployment/refs/heads/main/endpoint_setup/deb-init.bash", then "sudo bash deb-init.bash"

# Create Deployment User on mgmt
read -p "enter deployment user password: " Pass
hashPass=$(openssl passwd -1 $Pass)
sudo useradd -m deployment -p $hashPass -s /bin/bash
sudo usermod -aG sudo deployment
