# progressbg.net Final Assignment
Assignment for the Progress DevOps Class of Nov 2020

![instructions](.github/progress_final.png?raw=true "instructions")

# Task
Build and deploy a web application. The app can send a text message (SMS) to a given phone number with provided content. The SMSs is sent via the AWS SNS service. The application runs in a docker container on an EC2 instance (part of an ASG). 

---

The docker image is created via CI/CD pipeline which will automatically build and deploy the docker image to an image registry.
The ASG is created as a part of a CloudFormation Stack. The EC2 instance will run a container based off the docker image.

---
# Overview of steps:
* create an ECR repository called `userX-web-app` - the built docker image will be stored there
* create a CodeCommit repo `userX-web-app`  - it will hold all of the code (this github repo + the two changes you need to make )
* create a Lambda called `userX-trigger-codebuild` (not needed if you have done it in the last homework) - the lambda will be activated by commits to CodeCommit and start a CodeBuild build
* create a CodeBuild project `userX-web-app`  - to build a docker image and push it to the ECR repo you made
* extend the CI bash script (check "What code you need to write")
* commit your code - this will result in a docker image in ECR
* extend the `template.yml` so that when the EC2 instance starts, it will run the docker container with the image you've pushed (check "What code you need to write")
* Create a CloudFormation stack - it will create the EC2 ASG with an EC2 in it which will run the application docker container
* When the stack is created, find the public IP of the created EC2 instance and access it via HTTP (not HTTPS) to open the web app (`http://<instance-public-ip>`)

# What code you need to write
* In `ci_scripts/build_docker_image.sh` - you need to implement the steps. 1) Check the "View push instructions" button in the ECR repository :) 2) during the build the `${APP}` environment variable is available - which will have the same value as your CodeCommit repo (and your ECR repo)
* in `template.yml` - you need to extend the `UserData` section - you need to write the command which will start the docker container from the image hosted on your ECR repo from Stage 2. The stack you'll create will receive as a parameter the name of the ECR repo - you need to use that in the command
---
# Instructions 
- Create an AWS "Elastic Container Registry" repository called `userX-web-app`
- Create a `userX-web-app` CodeCommit repo
  - Clone this repo (i.e. the one you are reading now),
  - once cloned remove the default "remote" & add as "remote origin" the CodeCommit repo you created. Use the provided HTTPS address of the repo. This way when you commit/push, the commits will go to you CodeCommit repo and not this github one.
- Create a CodeBuild project, called `userX-web-app`. Please check the [instructions](https://github.com/jorotenev/devops_course/tree/master/Part%202%20-%20AWS/demos/homework) from the last homework on how to do that 
  - !!!!! **put a tick on "Enable this flag if you want to build Docker images or want your builds to get elevated privileges"**
  - use the `arn:aws:iam::378652049675:role/codebuild-role-homework` role
- `userX-trigger-codebuild` lambda - it will be triggered by commits to your CodeCommit repo and will start a CodeBuild build 
  - if you have created the `userX-worker-trigger-codebuild` lambda from the last homework, then just add a new CodeCommit trigger to it - put the CodeCommit `userX-web-app` repo you created now.
  - if you haven't done this - read the ["Create the trigger-codebuild worker lambda"](https://github.com/jorotenev/devops_course/tree/master/Part%202%20-%20AWS/demos/homework) section from the last homework

- extend the ci_scripts/ bash file now
- commit it and push it. Check your CodeBuild builds. If successful, go to your ECR repo - you should see a docker image there
- extend the `template.yml` now & use it to create a CloudFormation stack (`userX-web-app`).
- Final step
  - find the IP address of the EC2 instance created by the stack and open `http://<instance-public-ip>`
  - send me your email address as an SMS :)
  - :beer:
  
  