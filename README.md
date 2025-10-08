# Wexa AI Next.js Application
This repository contains a Next.js application created with npx create-next-app@latest, containerized using Docker, automated with GitHub Actions for building and pushing to GitHub Container Registry (GHCR), and deployed to a local Kubernetes cluster using Minikube. This project fulfills the requirements of the DevOps Internship Assessment.
Prerequisites
To set up and run this project, ensure you have the following installed:


Docker (for building and running the container)
Minikube (for local Kubernetes deployment)
kubectl (for interacting with the Kubernetes cluster)
Git (for cloning the repository)
A GitHub account with access to GitHub Container Registry (GHCR)

Setup Instructions

Clone the Repository
```shell
git clone https://github.com/munagalasandeep99/wexa_ai_assignment.git
cd wexa_ai_assignment
```


# Build and Run Locally with Docker

Build the Docker image:
```shell
docker build -t wexa-ai-app:latest .
```

Run the Docker container:
```shell
docker run -p 3000:3000 wexa-ai-app:latest
```
The application will be accessible at http://localhost:3000.



# GitHub Actions Workflow
The repository includes a GitHub Actions workflow (.github/workflows/publish-ghcr.yml) that:

Triggers on push to the main branch.
Builds the Docker image for the Next.js application.
Tags the image with latest, the GitHub Actions build number, and the short commit SHA.
Pushes the image to GitHub Container Registry (GHCR).

# To configure the workflow:

- Ensure you have a Personal Access Token (PAT) with write:packages scope.
- Add the PAT as a repository secret named GH_PAT in GitHub under Settings > Secrets and variables > Actions.
- The workflow will automatically build and push the image to:ghcr.io/munagalasandeep99/wexa_ai_assignment:latest



# Deploying to Minikube

Start MinikubeEnsure Minikube is running:
```shell
minikube start
```

Apply Kubernetes ManifestsThe Kubernetes manifests are located in the k8s/ directory:

deployment.yaml: Defines a Deployment with 2 replicas, liveness and readiness probes, and pulls the image from ghcr.io/munagalasandeep99/wexa_ai_assignment:latest.
service.yaml: Exposes the application via a NodePort service, mapping port 80 to the container's port 3000.

Apply the manifests:
```shell
kubectl apply -f manifest_files/deployment.yaml
kubectl apply -f manifest_files/service.yaml
```

# Access the Application

Expose the service using Minikube:minikube service wexa-ai-service

This will open the application in your default browser or provide a URL ```(e.g., http://<minikube-ip>:<node-port>).```
# Alternatively, use port-forwarding:
```shell
kubectl port-forward service/wexa-ai-service 3000:80
```
The application will be available at http://localhost:3000.



# Accessing the Deployed Application

After deploying to Minikube, use the minikube service wexa-ai-service command to get the application URL.
If using port-forwarding, access the application at http://localhost:3000.
The service is exposed via NodePort, so the Minikube URL will include a dynamically assigned node port (check with kubectl get services).


