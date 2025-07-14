# 🔐 Keycloak Deployment on K3s using Terraform

This repository automates the setup of a local Kubernetes cluster using K3s, installs `cert-manager` for TLS support, and deploys Keycloak securely — all through Terraform.

---

## ✅ Prerequisites

Before starting, ensure your machine has:

- ✅ Internet access
- ✅ Terraform installed (version ≥ 1.0 recommended)
- ✅ Linux/macOS system with `sudo` access

---

## 🛠️ Local DNS Setup

You must configure your local `/etc/hosts` file to map `keycloaktest.com` to your private IP.

### Steps:

1. Find your machine’s private IP (e.g., `192.168.1.10`)
2. Open `/etc/hosts` with a text editor:

```bash
sudo nano /etc/hosts
```

3. Add the following line (replace with your actual IP):

```
192.168.x.x    keycloaktest.com
```

---

## 🚀 Deployment Steps

Clone this repository and navigate to its directory. Then run:

```bash
terraform init
terraform apply -auto-approve
```

Terraform will:

- Install a local K3s cluster
- Deploy cert-manager
- Deploy Keycloak
- Expose Keycloak over HTTPS using a self-signed certificate

---

## 🌐 Accessing Keycloak

Once setup is complete, open your browser and go to:

👉 [https://keycloaktest.com](https://keycloaktest.com)

> ⚠️ You may see a browser security warning due to the self-signed certificate. It is safe to proceed.

### 🔑 Default Admin Credentials

- **Username:** `admin`
- **Password:** `admin`

---

## 📂 Project Structure

```text
.
├── main.tf                  # Terraform configuration
├── variables.tf             # Optional input variables
├── outputs.tf               # Terraform output values
├── cert-manager.yaml        # (Optional) cert-manager CRDs
├── keycloak.yaml            # (Optional) Keycloak manifest
├── local-manifests/         # Additional Kubernetes YAMLs
└── README.md                # This file
```

---

## 📌 Notes

- This setup is designed for **local development/testing only**.
- You can replace the self-signed certificate with Let's Encrypt by updating the `ClusterIssuer`.
- Make sure port 443 is open if accessing from other devices on your network.****
