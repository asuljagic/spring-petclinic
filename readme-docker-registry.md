# Local Docker Registry setup

To start the registry container we need to run the following command:

    docker run -d -p 5000:5000 --restart=always --name registry registry:2

Next, we will create additional tag for the existing image and when the first part is hostname and port, Docker will interpret this as the location of the registry:

    docker tag spring-petclinic_petclinic:latest localhost:5000/petclinic-app
After that we will push the image to the local registry running at **localhost:5000**

    docker push localhost:5000/petclinic-app
Since we want to push and pull all images from local registry we'll do the same thing for **posgtres** image.
Creating a new tag:

    docker tag postgres:14.1 localhost:5000/psql-petclinic
Pushing the image to local registry:

    docker push localhost:5000/psql-petclinic

## Testing the registry
To assure that image was successfully pushed to the local docker registry we will first remove locally-cached **spring-petclinic_petclinic** and **localhost:5000/petclinic-app** images:

    docker image remove spring-petclinic_petclinic
    docker image remove localhost:5000/petclinic-app
We will do the same thing for postgres:

    docker image remove postgres
    docker image remove localhost:5000/psql-petclinic

After that we need to pull the images from the registry:

    docker pull localhost:5000/petclinic-app
    docker pull localhost:5000/psql-petclinic
To confirm that image was successfully pushed to local registry, we can check with following command:

    curl -X GET http://localhost:5000/v2/_catalog
The response in our case should be:

    {"repositories":["petclinic-app","psql-petclinic"]}