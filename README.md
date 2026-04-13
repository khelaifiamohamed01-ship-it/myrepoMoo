# TaskMaster: High-Availability AWS Web Suite

## Project Overview
This project demonstrates a resilient, three-tier cloud architecture designed to handle high traffic and ensure 100% uptime for the TaskMaster application.

## Architecture Diagram
```mermaid
graph TD
    User((User)) --> ALB[Application Load Balancer]
    subgraph VPC [TaskMaster VPC]
        ALB --> ASG[Auto Scaling Group]
        subgraph AZs [Multi-AZ Deployment]
            ASG --> EC2_1[Web Server 1]
            ASG --> EC2_2[Web Server 2]
        end
        EC2_1 --> RDS[(MySQL Database)]
        EC2_2 --> RDS
    end
        EC2_1 --> RDS[(MySQL Database)]
        EC2_2 --> RDS
    end


### Application Live
This screenshot shows the TaskMaster application successfully running through the Load Balancer DNS.
![App Working](screenshots/app-working.png)

### Target Group Health Status
Proof that the Auto Scaling Group and Load Balancer are correctly communicating with the EC2 instances.
![Health Check](screenshots/healthy-targets.png)
