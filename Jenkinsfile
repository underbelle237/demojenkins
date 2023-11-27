pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = sh(script: 'aws ssm get-parameter --name /MyApp/AWS/AccessKey --query "Parameter.Value" --output text', returnStdout: true).trim()
        AWS_SECRET_ACCESS_KEY = sh(script: 'aws ssm get-parameter --name /MyApp/AWS/SecretKey --query "Parameter.Value" --output text', returnStdout: true).trim()
    }

    parameters {
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select Apply or Destroy')
    }

    stages {
        stage('Install AWS CLI') {
            steps {
                script {
                    sh 'curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'
                    sh 'unzip awscliv2.zip'
                    sh './aws/install'
                }
            }
        }

        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/underbelle237/demojenkins']]])
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply or Destroy') {
            steps {
                echo "Apply or Destroy is --> ${params.action}"
                sh "terraform ${params.action} -auto-approve"
            }
        }
    }
}
