# Setting up main node as Image registry

Steps to create local docker registry were documented in separate readme file (`readme-docker-registry.md`).
Instead of using localhost we'll provide IP address of our main node and do the following configuration:
First we'll provide new tags for both postgres and petclinic images:

    $ docker tag spring-petclinic_petclinic <ip address of master>:5000/petclinic-app
    $ docker tag postgres:14.1 <ip address of master>:5000/psql-petclinic
**Note**: IP address of master is configured as private network in Vagrantfile.
If we try to push to this new tag we'll get a following message:

    Get "https://192.168.56.103:5000/v2/": http: server gave HTTP response to HTTPS client
This means that client expects HTTPS response from server and in order to fix this we need to configure **daemon.json** located in `/var/docker` folder.
First we need to create this file inside the folder ( if it doesn't exists):

    # touch /var/docker/daemon.json
After that we need to provide following configuration in this file:

    {
	    "insecure-registries":["192.168.56.103:5000"]
    }
Next, we need to save these changes and restart docker service:

    # service docker restart
After this, all we need to do is push images to these locations

    $ docker push 192.168.56.103:5000/petclinic-app
    $ docker push 192.168.56.103:5000/psql-petclinic
To check if images are successfully stored in registry:

    $ curl -X GET http://192.168.56.103:5000/v2/_catalog
Response should be:

    {"repositories":["petclinic-app","psql-petclinic"]}
**Note**: Since agent node will be doing jobs, we also need to configure communication with the master node as Image registry. Just repeat steps from the above regarding adding **daemon.json** and configuring master node IP address.
