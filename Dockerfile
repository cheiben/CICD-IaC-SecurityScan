FROM jenkins/jenkins:lts

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    wget \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    unzip \
    git \
    ca-certificates \
    apt-transport-https

# Install Checkov
RUN pip3 install --break-system-packages checkov

# Install Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform

# Create directory for reports
RUN mkdir -p /var/jenkins_home/reports && \
    chown -R jenkins:jenkins /var/jenkins_home/reports

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Switch back to jenkins user
USER jenkins

# Jenkins home volume
VOLUME /var/jenkins_home

# Add custom initialization settings if needed
# COPY init.groovy.d/ /var/jenkins_home/init.groovy.d/

# Expose ports for web UI and agent connections
EXPOSE 8080 50000