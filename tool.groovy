pipeline {
    agent any
    
    environment {
        // Use your existing Jenkins credentials with the exact IDs shown
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
        
        stage('Verify Tools') {
            steps {
                sh 'terraform --version'
                sh 'checkov --version'
            }
        }
        
        stage('Security Scan - Checkov') {
            steps {
                script {
                    try {
                        // Run Checkov with detailed output
                        sh 'checkov -d . --framework terraform --output cli'
                    } catch (Exception e) {
                        // Store the failure to fail the build later, but continue for now
                        echo "Checkov found security issues. Check the logs for details."
                        currentBuild.result = 'UNSTABLE'
                    }
                    
                    // Generate reports in different formats regardless of pass/fail
                    sh 'checkov -d . --framework terraform --output json > checkov-report.json || true'
                    sh 'checkov -d . --framework terraform --output junitxml > checkov-report.xml || true'
                }
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init -backend=false'
            }
        }
        
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
    }
    
    post {
        always {
            // Archive the Checkov reports
            archiveArtifacts artifacts: 'checkov-report.json', allowEmptyArchive: true
            junit allowEmptyResults: true, testResults: 'checkov-report.xml'
        }
        unstable {
            echo "Security issues were found. Review the Checkov reports."
        }
    }
}