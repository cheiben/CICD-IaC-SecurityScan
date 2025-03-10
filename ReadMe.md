# Infrastructure as Code Security Scanning Pipeline

This repository contains a Jenkins pipeline for scanning Infrastructure as Code (IaC) resources for security issues using [Checkov](https://www.checkov.io/) and validating Terraform configurations.

## Overview

The pipeline performs the following tasks:
- Verifies required tools are installed (Terraform and Checkov)
- Scans Terraform code for security vulnerabilities using Checkov
- Initializes and validates Terraform configurations
- Archives scan results for review

## Prerequisites

- Jenkins server with:
  - Terraform installed
  - Checkov installed
  - Azure credentials configured in Jenkins

## Configuration Files

### Pipeline Configuration (Jenkinsfile)

The Jenkinsfile defines a pipeline that:
- Sets up Azure credentials from Jenkins secrets
- Checks out the source code
- Verifies that Terraform and Checkov are installed
- Runs a security scan on the Terraform code
- Initializes and validates the Terraform configuration
- Archives the scan results

### Checkov Configuration (.checkov.yaml)

The Checkov configuration file should be created in your repository root to customize the security scanning behavior. Key settings include:
- Compact output format
- Directory to scan
- Variable evaluation
- Frameworks to include in scanning (Terraform, secrets, etc.)
- Path exclusions
- Output formats and locations

## Docker Setup

For optimal production use, create a Docker image with all necessary tools pre-installed. The Dockerfile should:
- Use Jenkins LTS as the base image
- Install Python and other dependencies
- Install Checkov via pip
- Install Terraform
- Create directories for reports
- Set up volume and port configurations

## Jenkins Credentials Setup

In Jenkins, configure the following credentials:
- `azure-client-id`: Azure Client ID
- `azure-client-secret`: Azure Client Secret
- `azure-subscription-id`: Azure Subscription ID
- `azure-tenant-id`: Azure Tenant ID

## Troubleshooting

### Common Issues

1. **Checkov not found**:
   - Ensure Checkov is installed correctly
   - Check PATH includes the location of the Checkov binary

2. **Configuration file error**:
   - Verify the `.checkov.yaml` file is valid YAML
   - Use the `--config-file /dev/null` option to bypass config file issues

3. **Permission errors**:
   - Use the Docker setup to avoid permission issues
   - Ensure the Jenkins user has appropriate permissions

## Customizing Security Checks

To customize security checks, modify your `.checkov.yaml` file to include or exclude specific checks. You can skip specific checks by referencing their IDs and adding comments to document why they're being skipped.

## References

- [Checkov Documentation](https://www.checkov.io/1.Welcome/Quick%20Start.html)
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Jenkins Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)

     By# Cheikh B
