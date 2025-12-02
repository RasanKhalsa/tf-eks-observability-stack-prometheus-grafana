output "monitoring_namespace" {
  description = "Monitoring namespace"
  value       = kubernetes_namespace.monitoring.metadata[0].name
}

output "grafana_admin_password" {
  description = "Grafana admin password"
  value       = var.grafana_admin_password
  sensitive   = true
}

output "prometheus_service" {
  description = "Prometheus service name"
  value       = "kube-prometheus-stack-prometheus.${kubernetes_namespace.monitoring.metadata[0].name}.svc.cluster.local:9090"
}

output "grafana_service" {
  description = "Grafana service name"
  value       = "kube-prometheus-stack-grafana.${kubernetes_namespace.monitoring.metadata[0].name}.svc.cluster.local"
}

output "alertmanager_service" {
  description = "Alertmanager service name"
  value       = "kube-prometheus-stack-alertmanager.${kubernetes_namespace.monitoring.metadata[0].name}.svc.cluster.local:9093"
}
/*
output "access_instructions" {
  description = "Instructions to access services"
  value       = <<-EOT
    
    === Access Instructions ===
    
    1. Grafana:
       %{if var.enable_grafana_loadbalancer~}
       - Get LoadBalancer URL:
         kubectl get svc -n ${kubernetes_namespace.monitoring.metadata[0].name} kube-prometheus-stack-grafana
       %{else~}
       - Port forward:
         kubectl port-forward -n ${kubernetes_namespace.monitoring.metadata[0].name} svc/kube-prometheus-stack-grafana 3000:80
       %{endif~}
       - Username: admin
       - Password: ${var.grafana_admin_password}
    
    2. Prometheus:
       - Port forward:
         kubectl port-forward -n ${kubernetes_namespace.monitoring.metadata[0].name} svc/kube-prometheus-stack-prometheus 9090:9090
       - Access: http://localhost:9090
    
    3. Alertmanager:
       - Port forward:
         kubectl port-forward -n ${kubernetes_namespace.monitoring.metadata[0].name} svc/kube-prometheus-stack-alertmanager 9093:9093
       - Access: http://localhost:9093
  EOT
}*/
