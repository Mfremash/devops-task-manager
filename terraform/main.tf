resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_namespace" "devops_helm" {
  metadata {
    name = "devops-helm"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "monitoring"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  values = [
    file("${path.module}/../monitoring/values/kube-prometheus-stack-values.yaml")
  ]
}

resource "helm_release" "devops_task_manager" {
  name      = "devops-task-manager"
  namespace = kubernetes_namespace.devops_helm.metadata[0].name
  chart     = "${path.module}/../helm/devops-task-manager"

  values = [
    file("${path.module}/../helm/devops-task-manager/values-dev.yaml")
  ]

  depends_on = [kubernetes_namespace.devops_helm]
}

