# 🚀 End-to-End DevSecOps on AWS — Yelp Camp

![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws)
![Docker](https://img.shields.io/badge/Docker-Containerization-blue?logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes)
![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform)
![Jenkins](https://img.shields.io/badge/Jenkins-CI-D24939?logo=jenkins)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?logo=argo)
![Helm](https://img.shields.io/badge/Helm-Packaging-0F1689?logo=helm)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Observability-F46800?logo=grafana)

A hands-on **end-to-end DevSecOps project on AWS** demonstrating containerization, CI, security scanning, infrastructure as code, Kubernetes deployment, GitOps, autoscaling, and observability.

The application is based on the Yelp Camp web application and was extended with a DevOps platform around it.

---

## 🎯 Project Objective

Build a repeatable delivery workflow in which application changes move from source control through automated quality/security checks and containerization into a Kubernetes-based production environment.

### Key DevOps capabilities demonstrated

- ☁️ AWS cloud infrastructure
- 🏗️ Infrastructure as Code with Terraform
- 🔄 CI with Jenkins
- 🐳 Docker containerization
- 🔐 Static analysis and image security scanning
- ☸️ Kubernetes / Amazon EKS deployment
- 📦 Helm-based application packaging
- 🔁 GitOps with Argo CD
- 📈 Horizontal Pod Autoscaling
- 📊 Prometheus + Grafana monitoring

---

## 🏗️ Architecture

```text
                         Developer
                             │
                             ▼
                         GitHub
                             │
                             ▼
                        ┌─────────┐
                        │ Jenkins │
                        └────┬────┘
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
          SonarQube        Docker         Trivy
        Code Quality       Build       Image Scan
                             │
                             ▼
                      Container Registry
                             │
                             ▼
                         Argo CD
                        (GitOps)
                             │
                             ▼
                       Helm Release
                             │
                             ▼
                    ┌─────────────────┐
                    │   Amazon EKS    │
                    │                 │
                    │ Deployment      │
                    │ Service         │
                    │ HPA             │
                    │ PDB             │
                    │ Resource Limits │
                    └────────┬────────┘
                             │
                    ┌────────┴────────┐
                    ▼                 ▼
               Prometheus         Grafana
               Metrics            Dashboards

              AWS Infrastructure
                    ▲
                    │
                 Terraform
```

---

## 🔄 CI/CD & GitOps Workflow

### Continuous Integration — Jenkins

1. Developer pushes code to GitHub.
2. Jenkins checks out the source code.
3. SonarQube performs code-quality analysis.
4. Docker image is built.
5. Trivy scans the container image for vulnerabilities.
6. Image is pushed to the configured container registry.

### Continuous Delivery — GitOps

Deployment responsibility is separated from the CI pipeline.

```text
GitHub
  │
  ├── Application Source
  │
  └── Kubernetes / Helm Configuration
              │
              ▼
           Argo CD
              │
              ▼
        Amazon EKS
```

Argo CD continuously reconciles the desired Kubernetes state with the cluster state.

---

## ☸️ Kubernetes Implementation

The `Manifests/` directory contains Kubernetes resources used for deployment and operations.

| Resource | Purpose |
|---|---|
| Deployment | Runs the application workload |
| Service | Exposes the application inside/outside the cluster |
| HPA | Automatically scales replicas based on resource utilization |
| PDB | Helps maintain application availability during disruptions |
| Resource / LimitRange | Controls resource allocation |
| Secret template | Defines application secret configuration without committing credentials |

---

## 🏗️ Infrastructure as Code

AWS infrastructure for the production environment is provisioned using **Terraform**.

The goal is to make infrastructure repeatable, version-controlled, and easier to reproduce across environments.

Typical workflow:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

---

## 🔐 DevSecOps

Security is incorporated into the delivery workflow rather than treated as a separate final step.

- **SonarQube** — code quality analysis
- **Trivy** — container image vulnerability scanning
- **Kubernetes Secrets** — application configuration/secrets management pattern
- **Terraform security practices** — infrastructure reviewed as code

> Never commit real credentials, tokens, database passwords, or private keys to Git. Use environment variables, secret managers, or CI/CD credential stores.

---

## 📊 Monitoring & Observability

The project uses:

- **Prometheus** for Kubernetes/application metrics collection
- **Grafana** for dashboards and visualization
- Kubernetes resource metrics for understanding workload utilization

This provides visibility into workload health and resource consumption after deployment.

---

## 🐳 Docker

The application uses a multi-stage Docker build based on Node.js.

The Docker workflow separates the build stage from the production runtime stage and installs production dependencies for the final image.

```text
Source Code
    │
    ▼
Docker Build
    │
    ├── Build Stage
    │
    └── Production Stage
            │
            ▼
      Container Image
```

---

## 🛠️ Technology Stack

| Category | Technologies |
|---|---|
| Cloud | AWS |
| Infrastructure | Terraform |
| Source Control | Git, GitHub |
| CI | Jenkins |
| Containers | Docker |
| Registry | Container Registry |
| Orchestration | Kubernetes, Amazon EKS |
| Packaging | Helm |
| GitOps | Argo CD |
| Code Quality | SonarQube |
| Security | Trivy |
| Monitoring | Prometheus, Grafana |
| Application | Node.js, Express |
| Database | MongoDB Atlas |
| Storage / APIs | Cloudinary, Mapbox |

---

## 📁 Repository Structure

```text
.
├── Dockerfile
├── docker-compose.yml
├── Manifests/
│   ├── 1.secret.example.yml
│   ├── 2.resource.yml
│   ├── 3.limitrange.yml
│   ├── 4.deploy.yml
│   ├── 5.svc.yml
│   ├── 6.hpa.yml
│   └── 7.pdb.yml
├── controllers/
├── models/
├── cloudinary/
├── images/
├── app.js
└── README.md
```

---

## 💻 Application Overview

The underlying application allows users to create, browse, review, and manage campgrounds.

The application stack includes:

- Node.js + Express
- MongoDB Atlas
- Passport authentication
- Mapbox
- Cloudinary
- Helmet
- Bootstrap

The **primary focus of this repository for my DevOps portfolio is the infrastructure, containerization, delivery, Kubernetes, GitOps, security, and observability implementation around the application.**

---

## 🚀 Local Development

Create your own environment configuration using the example file and provide your own values.

```bash
cp .env.example .env
```

Then start the application:

```bash
docker compose up
```

Do not commit `.env` or real credentials.

---

## 📸 Application

### Home

![Home](./images/home.jpg)

### Campgrounds

![Campgrounds](./images/campgrounds.jpg)

### Registration

![Registration](./images/register.jpg)

---

## 🎓 What This Project Demonstrates in an Interview

This project can be discussed through practical DevOps scenarios such as:

- How Jenkins performs CI and where security scanning fits
- Why CD was separated from Jenkins using GitOps
- How Argo CD reconciles Kubernetes desired state
- How EKS workloads are exposed using Kubernetes Services
- How HPA scales workloads
- How Terraform makes AWS infrastructure repeatable
- How Docker images are built and scanned
- How Prometheus and Grafana provide operational visibility
- How secrets should be managed safely

---

## 👨‍💻 Author

**Sandeep Reddy**  
AWS Cloud & DevOps Engineer

Focused on AWS, Kubernetes, Docker, Terraform, Jenkins, Helm, GitOps, monitoring, security, and cloud automation.

[GitHub Profile](https://github.com/sandeepreddy-karri)
