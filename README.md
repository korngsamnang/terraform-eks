# Terraform EKS & Jenkins Setup

This repository contains Terraform configurations to provision a Jenkins server and an Amazon EKS (Elastic Kubernetes Service) cluster. The setup allows creating EKS either via Jenkins or locally.

> Diagram flow
> ![](https://github.com/user-attachments/assets/a6f927b8-ad9c-403b-9674-d23cb4eff425)

## Directory Structure

```
terraform-eks/
│── eks/ # Terraform configuration for EKS
│ ├── .gitignore # Git ignore file
│ ├── backend.tf # Remote state backend configuration
│ ├── data.tf # Data sources used in Terraform
│ ├── kubernetes.tf # Kubernetes resource definitions
│ ├── main.tf # Main Terraform configuration
│ ├── provider.tf # Provider configurations
│ ├── terraform.tfvars # Terraform variables file
│ ├── variables.tf # Variables definition file
│
│── jenkins-server/ # Terraform configuration for Jenkins server
│ ├── .gitignore # Git ignore file
│ ├── backend.tf # Remote state backend configuration
│ ├── data.tf # Data sources used in Terraform
│ ├── jenkins-install.sh # Script to install Jenkins
│ ├── main.tf # Main Terraform configuration
│ ├── provider.tf # Provider configurations
│ ├── terraform.tfvars # Terraform variables file
│ ├── variables.tf # Variables definition file
│
│── Jenkinsfile # Jenkins pipeline to create EKS
```

## Prerequisites

Ensure you have the following installed on your local machine:

-   Terraform (>= 1.0)
-   AWS CLI (configured with the necessary permissions)
-   Jenkins (if running locally, or use the Terraform setup)
-   kubectl (for managing Kubernetes resources)

## Deploy Jenkins Using Terraform

1. Navigate to the jenkins-server directory:

```
cd terraform-eks/jenkins-server
```

2. Initialize Terraform:

```
terraform init
```

3. Plan the deployment

```
terraform plan
```

4. Apply the changes to deploy Jenkis:

```
terraform apply -auto-approve
```

5. Once completed, retrieve the Jenkins server IP:

```
terraform output jenkins_ip
```

Access Jenkins via `http://<jenkins_ip>:8080`.

6. Follow the on-screen instructions to complete the Jenkins setup.

## Deploy EKS Using Terraform

KS can be deployed either:

1. Locally using Terraform
2. Through Jenkins (Pipeline)

### Deploy EKS Locally

1. Navigate to the `eks` directory:

```
cd terraform-eks/eks
```

2. Initialize Terraform"

```
terraform init
```

3. Plan the deployment:

```
terraform plan
```

4. Apply the Terraform configuration to create the EKS cluster:

```
terraform apply -auto-approve
```

5. Retrieve the Kubernetes configuration to interact with the cluster:

```
aws eks update-kubeconfig --region <your-region> --name <eks-cluster-name>
```

6. Verify the cluster is running:

```
kubectl get nodes
```

### Deploy EKS Using Jenkins

1. In Jenkins, create a new Pipeline project.
2. Connect the repository containing this Terraform setup.
3. Configure Jenkins to use the `Jenkinsfile` in the root directory.
4. Run the pipeline, which will execute Terraform commands to create the EKS cluster.

## Destroying the Infrastructure

To destroy the created resources:

-   Jenkins Server:

```
cd terraform-eks/jenkins-server
terraform destroy -auto-approve
```

-   EKS cluster:

```
cd terraform-eks/eks
terraform destroy -auto-approve
```

## Deploy the Application

We are going to deploy the application to the EKS cluster. The process is shown in the diagram below.

![](https://github.com/user-attachments/assets/d877a38a-bb24-4bdf-a75a-c0f21aa647ba)
