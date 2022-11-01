#!/bin/bash

tag=$1
docker build --tag hixdev/k8sw8:$tag --platform=linux/amd64 --progress=plain .
docker tag hixdev/k8sw8:$tag hixdev/k8sw8:latest
docker push hixdev/k8sw8:$tag
docker push hixdev/k8sw8:latest
