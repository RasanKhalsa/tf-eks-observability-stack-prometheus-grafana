# Copy this file to terraform.tfvars and update with your values

aws_region                  = "us-east-1"
cluster_name                = "*********" # Replace with your cluster name
monitoring_namespace        = "monitoring"
grafana_admin_password      = "*****" # Replace with a strong password
prometheus_retention        = "10d"
prometheus_storage_size     = "20Gi"
grafana_storage_size        = "10Gi"
enable_grafana_loadbalancer = false  # Set to false for production
