pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCESS_KEY_ID     = AKIAQCE4XNK5AZHGZFU7
        AWS_SECRET_ACCESS_KEY = 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
    }

    parameters {
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select Apply or Destroy')
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
