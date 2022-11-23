# Setting up master-slave architecture in Jenkins

This document will provide steps for setting up Jenkins server on main node, as well as setting up Jenkins agent on agent node.


## Configuring main (master) node

After we installed **Java** and **Jenkins** on our main node, we need to do following configuration to connect it to the **agent** node.
Since we will be choosing connection to the agent via SSH, we will first need to generate the SSH key pair.
As root user we'll do the following:

    root@main:~# su - jenkins
    jenkins@main:~$ ssh-keygen
Public/private key pair will be generated and private key will be save in file `/var/lib/jenkins/.ssh/id_rsa`.
After that we will need to setup the credentials on Jenkins using the following settings:

 - Kind: SSH Username with private key
 - Scope: Global
 - Username: jenkins
 - Private key: check **Enter directly** and copy and paste contents of generated **id_rsa** file from master.

## Configuring agent node

On agent node we'll need to install **Java** and create new Jenkins user as follows:
First we need to switch to root user:

    sudo su -
After that add user and set password:

    root@agent:~# useradd -m -s /bin/bash jenkins
    root@agent:~# passwd jenkins
Next, we need to create jenkins folder in `/var/lib/`, and **.ssh** folder inside jenkins folder:

    root@agent:~# mkdir /var/lib/jenkins
    root@agent:~# mkdir /var/lib/jenkins/.ssh
After that we need to create **authorized_keys** file and copy and paste contents of `/var/lib/jenkins/.ssh/id_rsa.pub` file of Jenkins master user:

    root@agent:~# touch /var/lib/jenkins/.ssh/authorized_keys
Copy the key inside the file using any preferred text editor and save it.
After that we need to change ownership and permissions for created folders and files:

    root@agent:~# chown -R jenkins /var/lib/jenkins/.ssh
    root@agent:~# chmod 600 /var/lib/jenkins/.ssh/authorized_keys
    root@agent:~# chmod 700 /var/lib/jenkins/.ssh

## Creating agent node on Jenkins server

 - Add new node
 - Node name: agent1 and choose **Permanent agent**
 - Description: optional
 - Remote root directory: /var/lib/jenkins/jenkins-pipeline
 - Labels: agent1
 - Launch method: Launch slave agent via SSH, enter the host IP address for agent node (in our case provided in Vagrantfile), choose the authentication using previously created Jenkins credentials and set Manually trusted key Verification strategy.

After that we are set to go.

