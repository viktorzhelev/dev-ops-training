#!/bin/bash -e

echo "logging to ECR"
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 378652049675.dkr.ecr.eu-west-1.amazonaws.com

echo "building docker image"
docker build -t user2-web-app .



echo "tagging the built docker image with the repo address"
docker tag user2-web-app:latest 378652049675.dkr.ecr.eu-west-1.amazonaws.com/user2-web-app:latest



echo "pushing docker image to ECR"
docker push 378652049675.dkr.ecr.eu-west-1.amazonaws.com/user2-web-app:latest



echo "done"

