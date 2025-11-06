
---

# **Automated Web Server Deployment using Terraform, Ansible, Docker, and GitHub Actions**

## **📘 Project Overview**

This project demonstrates a fully automated **Infrastructure-as-Code (IaC)** workflow to provision, configure, and deploy a web application on **AWS EC2** using:

* **Terraform** – Infrastructure provisioning (EC2, Security Groups, etc.)
* **Ansible** – Configuration management (install Docker, deploy Nginx)
* **Docker** – Containerized Nginx web server hosting HTML files
* **GitHub Actions** – CI/CD automation to deploy updates on every code push

The pipeline automatically deploys your website to an existing EC2 instance whenever you push new commits to the `main` branch.

---

## **🚀 Key Components**

| Tool               | Purpose                                              |
| ------------------ | ---------------------------------------------------- |
| **Terraform**      | Provisions AWS infrastructure (EC2, Security Groups) |
| **Ansible**        | Installs Docker and deploys Nginx container          |
| **Docker**         | Hosts the static HTML website inside a container     |
| **GitHub Actions** | Automates CI/CD to update EC2 instance on each push  |
| **AWS EC2**        | Cloud host for the Nginx web server                  |

---

## **🧩 Project Architecture**

```plaintext
terraform-ansible-docker-nginx/
├── .github/
│   └── workflows/
│       └── deploy.yml                # CI/CD pipeline (Terraform + Ansible)
│
├── ansible/
│   ├── inventory.tpl                 # Template file for dynamic EC2 IP (CI/CD)
│   ├── inventory.ini                 # Static/local inventory (for testing)
│   ├── install-docker.yml            # Installs Docker on EC2
│   └── deploy-nginx.yml              # Deploys Nginx + HTML website via Docker
│
├── html/
│   ├── index.html                    # Home page (Tailwind-styled)
│   ├── about.html                    # About page with navigation
│   └── style.css                     # Optional custom styling
│
├── main.tf                           # Terraform configuration (EC2 + SG)
├── outputs.tf                        # Terraform outputs (EC2 public IP)
├── Network.pem                       # SSH key (not committed to GitHub)
└── README.md                         # Project documentation
```

---

## **⚙️ Infrastructure Workflow**

### **1. Terraform (Infrastructure Provisioning)**

Terraform automatically:

* Creates a **Security Group** allowing SSH (22) and HTTP (80)
* Launches an **Amazon Linux 2 EC2 instance**
* Outputs the **instance public IP** for use by Ansible

Example commands (run locally or in CI/CD):

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

---

### **2. Ansible (Configuration Management)**

Ansible automates:

* Installing Docker via `amazon-linux-extras`
* Adding `ec2-user` to the Docker group
* Deploying an **Nginx container** with mounted HTML files
* Copying your web content from `/html/` directory to `/usr/share/nginx/html`

Run manually (for testing):

```bash
ansible-playbook -i ansible/inventory.ini ansible/install-docker.yml
ansible-playbook -i ansible/inventory.ini ansible/deploy-nginx.yml
```

---

### **3. GitHub Actions (CI/CD Pipeline)**

The CI/CD pipeline in `.github/workflows/deploy.yml` performs:

| Step | Description                                    |
| ---- | ---------------------------------------------- |
| 1    | Checks out your repository                     |
| 2    | Sets up Terraform                              |
| 3    | Configures AWS credentials                     |
| 4    | Applies Terraform (ensures EC2 exists)         |
| 5    | Retrieves EC2 public IP dynamically            |
| 6    | Installs Python & Ansible                      |
| 7    | Generates inventory.ini from template          |
| 8    | Connects to EC2 via SSH                        |
| 9    | Runs Ansible playbooks (Docker + Nginx + HTML) |
| 10   | Prints final deployment URL                    |

**Trigger:** Automatically runs on every `git push` to `main`.

---

## **🔐 Required GitHub Secrets**

Before running the workflow, configure these repository secrets in
**GitHub → Settings → Secrets → Actions → “New Repository Secret”**

| Secret Name             | Description                               |
| ----------------------- | ----------------------------------------- |
| `AWS_ACCESS_KEY_ID`     | Your AWS IAM access key                   |
| `AWS_SECRET_ACCESS_KEY` | Your AWS IAM secret key                   |
| `EC2_SSH_KEY`           | Paste contents of your `Network.pem` file |

---

## **🌐 Deployment Flow**

1. Developer edits HTML/CSS files in `/html/`
2. Commit and push changes to the `main` branch
3. GitHub Actions pipeline triggers automatically
4. Terraform ensures EC2 infrastructure exists
5. Ansible installs Docker (if needed) and redeploys Nginx
6. New website version is instantly live on the same EC2 instance

---

## **📡 Accessing Your Website**

Once deployment completes successfully, GitHub Actions outputs the public URL:

```
Deployment Completed Successfully!
Access your site at: http://<EC2_PUBLIC_IP>
```

Example:

```
http://34.201.71.243
```

---

## **✅ Testing the Deployment**

You can test the full pipeline manually:

```bash
# Initialize and apply Terraform
terraform init
terraform apply -auto-approve

# Get instance IP
terraform output instance_public_ip

# Deploy via Ansible
ansible-playbook -i ansible/inventory.ini ansible/install-docker.yml
ansible-playbook -i ansible/inventory.ini ansible/deploy-nginx.yml
```

Then visit your EC2 instance’s IP address in a browser.

---

## **🧱 Technologies Used**

| Category                 | Technology     |
| ------------------------ | -------------- |
| Cloud Provider           | AWS EC2        |
| IaC Tool                 | Terraform      |
| Configuration Management | Ansible        |
| Containerization         | Docker         |
| Web Server               | Nginx          |
| CI/CD Platform           | GitHub Actions |
| Language Runtime         | Python 3.8     |
| OS                       | Amazon Linux 2 |

---

## **🧭 Future Improvements**

* Add HTTPS using **AWS Certificate Manager + Nginx SSL config**
* Push Docker image to **Amazon ECR**
* Deploy with **AWS ECS or Fargate**
* Add automated **testing and rollback**

---

## **Summary**

This project showcases a complete DevOps pipeline built entirely with open-source tools:

* Terraform provisions AWS resources
* Ansible configures and deploys Nginx automatically
* GitHub Actions enables continuous deployment
* The result: a single automated pipeline from code commit → live website

