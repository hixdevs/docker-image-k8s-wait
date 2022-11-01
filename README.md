# Kubernetes Wait

A simple `hixdev/k8sws` alpine-based docker image with a single `curl`
dependency, and an `sh` function `k8sw8` that can be used inside K8S'
`initContainers` for a Deployment to wait for other Deployments.

## Usage

Imagine having two K8S Deployments.

### First Deployment - API

We have a simple API that exposes `/health` endpoint - whenever API is ready, it
responds with HTTP 200.

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
spec:
  template:
    spec:
      containers:
        - name: api
          image: example/api:0.0.0
```

### Second Deployment - WWW

We have a frontend WWW app, that needs the API to build its static pages during
Deployment's spinoff.

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: www
spec:
  template:
    spec:
      initContainers:
        - name: api-w8
          image: hixdev/k8sw8:latest
          env:
            ## Required
            - name: WAIT_URL
              value: http://api:3000/health
            ## Optional
            - name: WAIT_CODE
              value: "204"
            - name: WAIT_TIME
              value: "15"
            - name: GROUP_ID
              value: "10001"
            - name: GROUP_NAME
              value: "k9sw9"
            - name: USER_ID
              value: "10002"
            - name: USER_ID
              value: "k9sw9"
          securityContext:
            runAsUser: 10002
            runAsGroup: 10001
      containers:
        - name: www
          image: example/www:0.0.0
          command:
            - /bin/sh
          args:
            - -cx
            - |
              npm run build
              npm run start
```

## Deployment

Do the following:

1. Run `docker login` as `hixdev` to [https://hub.docker.com](https://hub.docker.com)
2. Run `./publish x.y.z.`

