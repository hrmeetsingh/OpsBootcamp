# OpsBootcamp
QA Bootcamp repo. 

## What's covered 

  - Docker container setup
  - Ansible setup for installation and configuration of webserver on target systems
  - Ansible tests for verifying installation and configuration works

## Setup
### Setup Docker container
- Use the following command while in parent folder -
`docker build -t "bootcampImage" .`
- Confirm new image is created by following command -
`docker images`
- Bring up Docker container
`docker run -it -p 2222:22 -p 8081:80 <imageId>`

### Setup an Ubuntu VM
- Use virtualbox to bring up a VM of Ubuntu
- Create root user password - 
`passwd root`
- Install openssh-server on the VM (ansible needs ssh) -
`apt-get install openssh-server`
- Edit '/etc/ssh/sshd_config' to change the value of 'PermitRootLogin' to 'yes'
- Start ssh service - 
`service ssh start`

### Establish secure passwordless SSH connection between Ansible master and target machines
Ansible requires a passwordless connection between systems or it will keep asking passwords when running configurations. These steps are common for docker image and VM
- Create ssh keys for your machine if already not there using `ssh-keygen` command
- Copy ssh keys to destination systems -

  For VM - `ssh-copy-id -i <path_to_your_public_ssh_key> root@<ipforVM>`

  Provide root password set for VM when asked to
  
  For container - `ssh-copy-id -i <path_to_your_public_ssh_key> -p 2222 root@127.0.0.1`
  
  #### Troubleshooting tip 
    If while doing an ssh for the first time, you get an error saying something like *'someone might be doing an MITM'*, one of the IPs you are trying to connect this time matches an IP your system already associates with a different machine signature - edit <your_home_directory>/.ssh/known_hosts file to remove any existing entries for the IP and try again

### Test everything is up for Ansible to take over
- Update `hosts` file with IP for VM
- Use `ping` command to confirm Ansible is ready - 
  `ansible -i hosts -m ping local`
 
### Run Ansible role on all target systems
- Use this command to get things done `ansible-playbook -i hosts playbook.yml`
