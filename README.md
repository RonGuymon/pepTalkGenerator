# pepTalkGenerator

This repository is primarily meant to be documentation for creating an API. Getting this from a simple set of code to an api on an AWS server took some learning. The plumber package makes it easy to turn code into an api, but getting it into Docker and then onto AWS was tricky. I'll do my best to outline the steps.

1. Create an R project (optional, but a good idea) with the files and script needed to perform the processs. Make sure it works. (See pepTalkCode.R)
2. Turn it into a plumber file by using the plumber package. (See peptalkplumber.R)
  * This will allow you to click the "Run API" button at the top, right and test it out on your machine to make sure it works.
  * The plumber package is cool because it allows you to create the endpoints and document everything in the script.
  * See https://www.rplumber.io/ for great documentation.
3. Create a file that will give instructions to run the plumber file. (See run-plumber.R)
  * We are going to put all the needed files into a self-contained docker container that can be run on any machine. This run-plumber file will be run when we start up the container and will tell docker what plumber file to run, and what port to expose.
4. Download docker desktop, and open it up. You will see a desktop application.
5. Use terminal to navigate to the folder where the project is located.
6. Create a dockerfile text file. (See dockerfile)
  * Be sure to name it "dockerfile".
  * This contains the instructions that docker will use to create a container that has an operating system, the required r packages and other programs required to run those packages (e.g., libssl-dev, libcurl4-gnutls-dev, pandoc), the port to expose, and what to run when the container is started.
7. Run the dockerfile in terminal: `docker build -t peptalk .`
  * __docker__: we are using the docker software
  * __build__: we are building a container
  * __-t peptalk__: we are going to tag it with the name we want to use, in this case peptalk.
  * __.__: We are going to put all the files in this folder into the docker container.
8. Run `docker images` and make sure that you can see it.
9. Run `docker run -p 80:80 peptalk` to make sure that the docker container is running correctly on your machine.
  * Terminal will print out, "Running swagger Docs at http://127.0.0.1:80/__docs__/". Copy that and paste it into your browser and test it out. It will look nice.
  * To stop it, open another terminal window and run `docker stop <container id>`. You can find the container id in the docker desktop interface.
10. Now it's time to put it onto AWS so that anyone can use it. Login to your AWS account.
11. First we need to create a container repository. 
  * Search for "ecr" and select "Repositories".
  * Select "Create repository"
  * General Settings: I selected "Public"
  * Details: Give it a name, like "peptalk"
  * Click "Create repository"
12. Push the docker container to the AWS repository.
  * Once the repository is created, click on the link for it and select, "View push commands". This will tell you all the terminal commands that you will need to run.
    * First make sure to install the AWS CLI (Amazon web services command line interface). I don't remember how to do that, but I think the "Registry Authentication" link took me to the needed instructions. This just needs to be done oncer per machine.
    * Run the authentication token command. This token expires after a while, perhaps a day.
    * Since the docker image is already built, you can jump to the tag image command. Running this will prepare it to be identified and pushed to the right AWS repository.
    * Run the docker push command. You should see comments about it being pushed, and see notifications of it's progress.
    * Refresh the repository page on AWS website, and you should see the peppy repository. Click on the name, which is a link. Copy the Image URI.
13. Create an AWS cluster.
  * I understand this to be a cluster of virtual server machines to handle the traffic that will be sent to it.
  * Search in AWS for "ecs", and select "Clusters".
  * "Create Cluster"
  * Select EC2 Linux + Networking
  * Give it a name: peppyCluster
  * EC2 instance type: select the smallest size the does the job so that you don't have to pay more than necessary. I used t2.nano. (It's free for the first year.)
  * Networking
    * VPC: default (first option)
    * Subnets: first option
    * Auto assign public IP: Enabled
    * Security group: default, or one that already is open to the public.
    * Create! Wait for it to finish creating. You now have a new EC2 cluster instance that you should be able to see in the EC2 dashboard.
14. Create a Task Definition in the Clusters menu.
  * Select "Task Definition" from the left sidebar.
  * "Create new Task Definition"
  * EC2, Next Step
  * Task definition name: peppyTask
  * Task role: None
  * Task memory: make sure that it's not more than what the instance can handle: 400 MiB, since the max for this t2.nano is 500 MiB.
  * Task CPU: 1 vcpu
  * Select "Add container": 
    * Give the container a name: peppyContainer
    * Image: Paste the image URI. (You may nave to navigate in a new window to the repository that you just pushed from docker if you didn't copy it earlier.)
    * Port mappings: 80:80
    * Click "Add". You should now see the container listed.
    * Click "Create". You will get a message on the screen if it worked.
15. Run a task on the newly created cluster
  * Click on the link for the newly created cluster.
  * Select "Task", and then "Run new Task"
    * Launch type: EC2
    Task Definition: peppyTask, or whatever you named the task.
    * Click, "Run Task". If it worked, then you will get a message indicating that is the case. If there is a memory problem, you will also see that. You may have to wait for the Last status to change from PENDING to RUNNING.
16. It's ready to test!
  * In the AWS browser,search for ec2 and select "EC2"
  * Select "instances". You should see something like "ECS instance" in the name column. Click on the Instance ID link for it.
  * Find the Public IPv4 DNS and copy that.
  * Paste it in a browser window and add on the endpoint, /pepTalk. So, in this case it is: http://ec2-35-153-126-74.compute-1.amazonaws.com/pepTalk
  * You should see a random pep talk!

  
  
    
  
  
