# Prometheus and Node Exporter Setup

## Prerequisites

1. **Install Prometheus**:
   Follow the guide to install Prometheus on your Ubuntu machine: [Install Prometheus on Ubuntu](https://www.cherryservers.com/blog/install-prometheus-ubuntu)

2. **Install Node Exporter**:
   Follow the official documentation to install Node Exporter: [Node Exporter Guide](https://prometheus.io/docs/guides/node-exporter/)

## Prometheus Configuration

Ensure your `prometheus.yml` configuration file is set up as follows to scrape metrics from Node Exporter:

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets: []

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# Scrape configuration for Prometheus
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node_exporter"
    static_configs:
      - targets: ["<NODE_EXPORTER_IP>:9100"]
      
      
# Configuration and Monitoring Setup

## Firewall Configuration

### Allow Ports in UFW

To configure the firewall using UFW (Uncomplicated Firewall), run the following commands to allow traffic on ports 9100 and 9090:

```bash
sudo ufw allow 9100/tcp
sudo ufw allow 9090/tcp
sudo ufw reload

# Network Security Group (NSG) Rules (for Azure VMs)
Ensure that your Network Security Group (NSG) rules allow inbound traffic on the necessary ports:

### Allow inbound traffic on port 9100.
### Allow inbound traffic on port 9090.

# Prometheus Query Language (PromQL) Basic Queries

## CPU Usage
```
Query: 100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```
### Description: Calculates the percentage of CPU usage by subtracting idle CPU time from 100%.

## Memory Usage
```
Query: node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes
```
### Description: Shows the amount of memory in use by subtracting available memory from the total memory.

## Disk I/O
```
Query: rate(node_disk_io_time_seconds_total[5m])
```
### Description: Measures the rate of disk I/O operations over the past 5 minutes.

## Network Traffic
```
Query: rate(node_network_receive_bytes_total[5m])
```
### Description: Displays the rate of incoming network traffic over the past 5 minutes.

## System Load
```
Query: node_load1
```
### Description: Shows the 1-minute load average of the system.
