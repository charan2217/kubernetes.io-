# Nginx App Development and Deployment using Kubernetes, Helm, and Jenkins

## 📌 Overview
This project demonstrates how to develop, containerize, and deploy an **Nginx web application** using **Kubernetes**, **Helm**, and **Jenkins**. The process includes setting up the Kubernetes environment, managing deployments with Helm, and automating CI/CD using Jenkins.

---
## 📁 Project Structure
```
├── helm-chart/         # Helm chart for deployment
│   ├── templates/     # Kubernetes YAML templates
│   ├── values.yaml    # Configuration values for Helm
├── jenkins-pipeline/  # Jenkins pipeline scripts
├── k8s-manifests/     # Kubernetes YAML manifests (if not using Helm)
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
├── Dockerfile         # Docker configuration
├── README.md          # This README file
```

---
## 🚀 Prerequisites
Ensure you have the following installed:
- [Docker](https://www.docker.com/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Jenkins](https://www.jenkins.io/)

---
## 🛠 Step 1: Build and Push Docker Image
```sh
docker build -t my-nginx-app .
docker tag my-nginx-app:latest <your-dockerhub-username>/my-nginx-app:latest
docker push <your-dockerhub-username>/my-nginx-app:latest
```

---
## 📌 Step 2: Kubernetes Deployment Using Helm
### 🏗️ Install Helm & Add Repo
```sh
helm repo add stable https://charts.helm.sh/stable
helm repo update
```

### 🚀 Deploy Nginx using Helm
```sh
cd helm-chart
helm install my-nginx ./ --set image.repository=<your-dockerhub-username>/my-nginx-app
```

### 🔄 Upgrade or Rollback Deployment
```sh
helm upgrade my-nginx ./
helm rollback my-nginx 1
```

### 🛑 Uninstall the Application
```sh
helm uninstall my-nginx
```

---
## 🏗 Step 3: Deploy with Jenkins CI/CD
### ✅ Install Jenkins in Kubernetes
```sh
helm repo add jenkins https://charts.jenkins.io
helm install my-jenkins jenkins/jenkins
```

### 🔑 Get Jenkins Admin Password
```sh
kubectl get secret --namespace default my-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode
```

### ⚡ Configure Jenkins Pipeline
- Create a **Jenkinsfile** with the following stages:
```groovy
pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t <your-dockerhub-username>/my-nginx-app:latest .'
                sh 'docker push <your-dockerhub-username>/my-nginx-app:latest'
            }
        }
        stage('Deploy with Helm') {
            steps {
                sh 'helm upgrade --install my-nginx ./helm-chart'
            }
        }
    }
}
```

### 🏗️ Run the Jenkins Pipeline
- Create a new Jenkins job
- Link it to your Git repository
- Run the pipeline to deploy your app

---
## ✅ Verification
### 🚀 Check Running Pods
```sh
kubectl get pods
```

### 🌐 Get Service URL
```sh
kubectl get svc my-nginx
```

### 🔄 Port Forward to Local Machine
```sh
kubectl port-forward svc/my-nginx 8080:80
```

Open `http://localhost:8080` in your browser to view your Nginx application.

---
## 🎯 Conclusion
You have successfully:
✅ Built an Nginx web application
✅ Deployed it using Kubernetes and Helm
✅ Automated deployment using Jenkins

---
## 📌 Next Steps
- Implement autoscaling with Horizontal Pod Autoscaler (HPA)
- Secure the application using Kubernetes Secrets & TLS Ingress
- Monitor application performance using Prometheus & Grafana

🚀 **Happy Coding!** 🎉
