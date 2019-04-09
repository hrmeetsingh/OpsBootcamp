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
`docker run -it -p 2222:22 -p 8081:80 <containerId>`

### Setup an Ubuntu VM
- Use virtualbox to bring up a VM of Ubuntu
- Create root user password - 
`passwd root`
- Install openssh-server on the VM (ansible needs ssh) -
`apt-get install openssh-server`
- Start ssh service - 
`service ssh start`

### Establish secure SSH connection between Ansible master and target machines
These steps are common for docker image and VM
- Create ssh keys for your machine if already not there using `ssh-keygen` command
- Copy ssh keys to destination systems -

  For VM - `ssh-copy-id -i <path_to_your_public_ssh_key> root@<ipforVM>`

  Provide root password set for VM when asked to
  
  For container - `ssh-copy-id -i <path_to_your_public_ssh_key> -p 2222 root@127.0.0.1`

### Test everything is up for Ansible to take over
- Update `hosts` file with IP for VM
- Use `ping` command to confirm Ansible is ready - 
  `ansible -i hosts -m ping local`
 
### Run Ansible role on all target systems
- Use this command to get things done `ansible-playbook -i hosts playbook.yml`
