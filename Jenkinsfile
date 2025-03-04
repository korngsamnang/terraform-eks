pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'ap-southeast-1'
    }
    stages{
        stage('Checkout SCM'){
            steps{
                script{
                   checkout scm
                }
            }
        }
         stage('Initializing Terraform'){
            steps{
                script{
                    dir('eks'){
                         sh 'terraform init'
                    }
                }
            }
        }
        stage('Formating terraform code'){
            steps{
                script{
                    dir('eks'){
                         sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform'){
            steps{
                script{
                    dir('eks'){
                         sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the infrastructure'){
            steps{
                script{
                    dir('eks'){
                         sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", ok: "proceed")
                }
            }
        }
        stage('Creating/Destroying an EKS cluster'){
            steps{
                script{
                    dir('eks'){
                         sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
    }
}