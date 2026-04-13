#!/bin/bash
# ------------------------------------------------------------------
# TaskMaster Application Bootstrap Script
# Purpose: Installs Apache, MariaDB client, and generates a dynamic
#          landing page that displays AWS Metadata.
# ------------------------------------------------------------------

# Update system and install web server
yum update -y
yum install -y httpd mariadb105
systemctl start httpd
systemctl enable httpd

# Retrieve AWS Metadata (Token-based for IMDSv2)
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Create the dynamic landing page
# REPLACE THE ENDPOINT BELOW WITH YOUR ACTUAL RDS ENDPOINT
cat <<EOF > /var/www/html/index.html
<html>
<body style='font-family: Arial; text-align: center; background-color: #f4f4f4;'>
    <div style='margin-top: 50px; border: 1px solid #ddd; display: inline-block; padding: 20px; background: white;'>
        <h1 style='color: #232f3e;'>TaskMaster App Live!</h1>
        <p>Deployment Status: <span style='color: green;'><b>ACTIVE</b></span></p>
        <p>Current Availability Zone: <b>$AZ</b></p>
        <hr>
        <p>Database Connectivity: <b>database-1.cu5vtckjwggi.us-east-1.rds.amazonaws.com</b></p>
    </div>
</body>
</html>
EOF
