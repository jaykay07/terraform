Terraform docker setup using nginx LB at front. 


###### Instructions and Guidelines #####

-	Build the custom image using the Dockerfile
#docker image build -t my_helloworld_image .
-	Login to the Docker Hub providing username/password
#docker login
Username: jaykaykay
Password: 
-	Tag the image
#docker image tag my_helloworld_image jaykaykay/my_helloworld_image
-	Push the image to docker hub
#docker image push jaykaykay/my_helloworld_image

  - AMI being used in ECS-optimized Linux (as this has most of docker and docker dependencies pre-installed).
  - Worker-nodes have port 8080 exposed only to internal VPC IPs and Nginx node has only 80 port exposed.
  - IPs added to /etc/hosts file using provisioner 'remote-exec'. Updating nginx conf files through user data.
  - Outputs Docker nodes private IP and Nginx nodes Public DNS name
  - Docker nodes can run multiple dockers at different port and nginx can be made to point them.
  - sample war file (helloworld.war) is downloaded from internet (https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/)


Imp: We can variablise Docker image input to make it more generic so that any of the AMI can be used. 

- You should have a system Terraform installed on it & PATH is set. From the terminal, run the below commands to execute the tf files.
- #terraform init
- #terraform apply –-auto-approve
