# EKS Observability Platform

> **Complete, production-ready Kubernetes observability for AWS EKS 1.32**

Kubernetes-native observability stack with Prometheus, Grafana, and Alertmanager.


## Prerequisites

- AWS EKS 1.32 cluster with managed nodes
- kubectl configured to access your cluster
- Terraform >= 1.5
- AWS CLI configured
- Helm 3.x

### 1. Deploy Monitoring Stack

```bash
cd terraform

# Copy and configure variables
vi terraform.tfvars
# Edit terraform.tfvars with your cluster name and preferences

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Deploy
terraform apply
```

### 2. Access Grafana

```bash

# use port-forward
kubectl port-forward -n monitoring svc/kube-prometheus-stack-grafana 3000:80

# If using LoadBalancer (not recommended)
kubectl get svc -n monitoring kube-prometheus-stack-grafana

# Access: http://localhost:3000
# Username: admin
# Password: (from terraform.tfvars)
```

### 3. Deploy Sample Workloads

## Using kubectl ##
```bash
# Deploy sample nginx application with metrics
kubectl apply -f testing/simple-app.yaml

# Deploy ServiceMonitor for metrics collection
kubectl apply -f testing/service-monitor.yaml

# Deploy Prometheus alerting rules
kubectl apply -f testing/prometheus-rules.yaml
```

### 4. Run Tests

#### Load Testing
```bash
# Generate HTTP traffic
kubectl apply -f testing/load-generator.yaml

# Monitor the job
kubectl get jobs -n sample-workloads -w
```

#### Stress Testing
```bash
# Trigger CPU and memory alerts
kubectl apply -f testing/stress-test.yaml

# Watch pods
kubectl get pods -n sample-workloads -w
```

### 5. Validate Metrics in Grafana

1. Login to Grafana (http://localhost:3000)
2. Navigate to Dashboards
3. Pre-installed dashboards:
   - Kubernetes / Compute Resources / Cluster
   - Kubernetes / Compute Resources / Namespace (Pods)
   - Node Exporter / Nodes
   - Prometheus / Overview

### 6. Validate Alerts

#### Check Alertmanager
```bash
# Port-forward Alertmanager
kubectl port-forward -n monitoring svc/kube-prometheus-stack-alertmanager 9093:9093

# Access: http://localhost:9093
```

## Key Components

- **Prometheus**: Metrics collection and storage (15 days retention, 20Gi storage)
- **Grafana**: Visualization with pre-configured dashboards
- **Alertmanager**: Alert routing and management
- **Node Exporter**: Host-level metrics from EKS nodes
- **Kube State Metrics**: Kubernetes object state metrics
- **ServiceMonitors**: Automatic service discovery for metrics

## Useful Commands

```bash
# Check monitoring stack status
kubectl get pods -n monitoring

# View Prometheus targets
kubectl port-forward -n monitoring svc/kube-prometheus-stack-prometheus 9090:9090
# Visit: http://localhost:9090/targets

# View all ServiceMonitors
kubectl get servicemonitors -A

# View all PrometheusRules
kubectl get prometheusrules -A

# Check Prometheus configuration
kubectl get prometheus -n monitoring -o yaml

# View logs
kubectl logs -n monitoring -l app.kubernetes.io/name=prometheus
kubectl logs -n monitoring -l app.kubernetes.io/name=grafana
```

## Testing Checklist

- [ ] Monitoring stack deployed successfully
- [ ] Grafana accessible and dashboards loading
- [ ] Prometheus scraping targets (check /targets)
- [ ] Sample workload deployed
- [ ] ServiceMonitor discovering metrics
- [ ] Load test generating traffic
- [ ] Grafana dashboards showing real-time data

## Cleanup

```bash
# Remove test workloads
kubectl delete -f testing/

# Remove monitoring stack
cd terraform
terraform destroy
```


## Next Steps (Future Phases)

- Configure Alertmanager notification channels (Slack, PagerDuty, Email)
- Set up Grafana LDAP/OAuth authentication
- Implement long-term metrics storage (Thanos/Cortex)
- Add distributed tracing (Jaeger/Tempo)
- Implement log aggregation (Loki)
- Set up service mesh observability (Istio/Linkerd)
- Add custom application metrics
