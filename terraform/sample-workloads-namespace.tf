# Sample Workloads Namespace
# This namespace is used for testing the monitoring stack with sample applications

resource "kubernetes_namespace" "sample_workloads" {
  metadata {
    name = "sample-workloads"
    
    labels = {
      name        = "sample-workloads"
      environment = "testing"
      purpose     = "monitoring-demo"
    }
  }
}

# Output the namespace name for reference
output "sample_workloads_namespace" {
  description = "Sample workloads namespace name"
  value       = kubernetes_namespace.sample_workloads.metadata[0].name
}
