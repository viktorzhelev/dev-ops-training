#!/bin/bash -e

image_name=user5-web-app
ECR=378652049675.dkr.ecr.eu-west-1.amazonaws.com

echo "logging to ECR"
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin $ECR


echo "building docker image"
docker build -t $image_name .


echo "tagging the built docker image with the repo address"
docker tag $image_name $ECR/$image_name:latest



echo "pushing docker image to ECR"
docker push $ECR/$image_name:latest



echo "done"

