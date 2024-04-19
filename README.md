
# Ansible Installation and Configuration Guide

This guide provides step-by-step instructions for installing Ansible on a Debian-based system, configuring it, and using it to manage servers and perform various tasks.

## Install Ansible by Python

1. Verify Python3 is installed:
    ```bash
    python3 --version
    ```
   
2. If Python3 is missing, install it:
    ```bash
    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt update
    sudo apt install python3.8
    sudo apt install python3-pip
    python3 --version
    ```

3. Install Dependencies:
    ```bash
    sudo apt-get install python3-minimal python3-virtualenv python3-dev build-essential
    ```

4. Set up virtualenv:
    ```bash
    mkdir ansible
    cd ansible
    virtualenv myansible
    ```

5. Activate Virtual Env:
    ```bash
    source myansible/bin/activate
    ```

6. Install Ansible:
    ```bash
    pip3 install ansible
    ```

7. Verify Ansible version:
    ```bash
    ansible --version
    ```

To exit from the virtual environment, use:
```bash
deactivate
```

## Install Ansible directly

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## Configure Ansible

### Way 1:
```bash
touch /tmp/ansible.cfg
export ANSIBLE_CONFIG=/tmp/ansible.cfg
```

### Way 2 (Preferred):
Go to the created ansible directory and execute:
```bash
touch ./ansible.cfg
```

### Way 3:
```bash
touch ~/.ansible.cfg
```

### Way 4:
```bash
touch /etc/ansible/.ansible.cfg
```

Check if Ansible is properly configured:
```bash
ansible --version
```

## Create hosts file

Navigate to the created Ansible directory and create a `hosts` file:
```bash
vim hosts
```

Add the following lines to the `hosts` file:
```ini
[all]
<user>:<ip of client1>
```

Create a `ansible.cfg` file and add the following lines:
```ini
[defaults]
host_key_checking = False
inventory = hosts
```

## Connect server to clients

1. Create SSH keys on the Ansible VM:
```bash
ssh-keygen
```

2. Create VMs (on AWS, GCP, or locally), add the public key of the Ansible server to them, ensure all of them have Python installed, and allow SSH access from the Ansible server.

3. Add the IP addresses of clients to the hosts file of Ansible:
```bash
cd ansible
vim hosts
```

Add the following lines to the `hosts` file:
```ini
[all]
ubuntu@123.43.34.5
ubuntu@123.43.34.6
```

Test the connection of the server with all clients in the hosts file:
```bash
ansible all -m ping
```

## Groups in Inventory file

Edit the hosts file to include groups:
```ini
[<group1_name>]
<user>@<ip of client2>
<user>@<ip of client3>
<user>@<ip of client4>

[<group2_name>]
<user>@<ip of client5>
<user>@<ip of client6>
<user>@<ip of client7>
```

Then, execute commands for a specific group:
```bash
ansible <group1_name> -m ping
```

For multiple groups at the same time:
```bash
ansible <group1_name>:<group2_name> -m ping
```

## Exec adhoc command on clients

Execute shell commands on clients:
```bash
ansible <group> -m shell -a "<command>"
```

Example:
```bash
ansible web_app -m shell -a "free -m"
```

## See the list of Ansible modules

```bash
ansible-doc -l
```

To see the description of a specific Ansible module:
```bash
ansible-doc -l <module_name>
```

Save the output in a file:
```bash
ansible-doc -l >> ans_mod.txt
```

## Additional Tips

- To keep binary files of commands on clients after execution:
  ```bash
  ANSIBLE_KEEP_REMOTE_FILES=1 ansible <group> -m shell -a "<command>"
  ```

- Copy a file from the server to clients:
  ```bash
  ansible <group> -m copy -a "src=<src_path> dest=<dest_path>"
  ```

- Put content directly into a file on clients:
  ```bash
  ansible <group> -m copy -a "content='<src_path>' dest=<dest_file_path>"
  ```

- Create/delete files or directories on clients:
  ```bash
  ansible <group> -m file -a "dest=<dest_file/dir_path> state=<state> mode=<permissions>"
  ```

- Install packages on clients:
  ```bash
  ansible <group> -m apt -a "name=<pkg_name> state=<state>" -b
  ```

- Get facts (information) of clients in JSON format:
  ```bash
  ansible <group> -m setup
  ```

- Filter facts to see specific information:
  ```bash
  ansible <group> -m setup -a "filter=ansible_memory_mb"
  ```

- Create custom facts:
  ```bash
  #!/bin/bash
  git_version=$(git --version | awk '{print $3}')
  apt_version=$(apt -v | awk '{print $2}')
  cat << EOF
  {
      "GIT_VERSION": "$git_version",
      "APT_VERSION": "$apt_version"
  }
  EOF
  ```

## Conclusion

This guide covers basic installation, configuration, and usage of Ansible. Explore further documentation and resources to delve deeper into Ansible's capabilities.
