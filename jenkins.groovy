pipeline {
    agent any
    
    environment {
        ARM_CLIENT_ID = credentials('azure-client-id')
        ARM_CLIENT_SECRET = credentials('azure-client-secret')
        ARM_SUBSCRIPTION_ID = credentials('azure-subscription-id')
        ARM_TENANT_ID = credentials('azure-tenant-id')
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Security Scan - Checkov') {
            steps {
                sh 'checkov -d . --quiet'
            }
        }
        
        stage('Security Scan - tfsec') {
            steps {
                sh 'tfsec . --format junit > tfsec-report.xml'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }
        
        stage('Approval') {
            steps {
                input message: 'Approve infrastructure changes?'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
    
    post {
        always {
            junit 'tfsec-report.xml'
            archiveArtifacts artifacts: 'tfplan', fingerprint: true
        }
    }
}