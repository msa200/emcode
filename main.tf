provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "null_resource" "install_k3s" {
  provisioner "local-exec" {
    command = "curl -sfL https://get.k3s.io | sh -"
  }

  triggers = {
    always_run = timestamp()
  }
}

resource "null_resource" "install_cert_manager" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.18.2/cert-manager.yaml"
  }

  depends_on = [null_resource.install_k3s]
}

resource "null_resource" "install_keycloak" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/refs/heads/main/kubernetes/keycloak.yaml"
  }

  depends_on = [null_resource.install_cert_manager]
}

resource "null_resource" "apply_local_manifests" {
  provisioner "local-exec" {
    command = "kubectl apply -f /root/emcode/manifests/"
  }

  depends_on = [null_resource.install_keycloak]
}

