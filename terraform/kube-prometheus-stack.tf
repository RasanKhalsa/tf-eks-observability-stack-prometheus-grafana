resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "56.0.0"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  values = [
    templatefile("${path.module}/values/prometheus-stack-values.yaml", {
      grafana_admin_password      = var.grafana_admin_password
      prometheus_retention        = var.prometheus_retention
      prometheus_storage_size     = var.prometheus_storage_size
      grafana_storage_size        = var.grafana_storage_size
      enable_grafana_loadbalancer = var.enable_grafana_loadbalancer
    })
  ]

  set {
    name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
    value = "false"
  }

  set {
    name  = "prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues"
    value = "false"
  }

  depends_on = [kubernetes_namespace.monitoring]
}
