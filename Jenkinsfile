pipeline {
    agent any

    parameters {
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select Apply or Destroy')
    }

    stages {
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
