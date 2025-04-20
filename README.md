
![Banner](https://raw.githubusercontent.com/ahmadsheikhi89/monitoring-stack-prometheus-grafana/main/banner.png)

![Shell Script](https://img.shields.io/badge/shell-bash-blue?logo=gnu-bash)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![OS: Rocky Linux 9.5](https://img.shields.io/badge/OS-Rocky%20Linux%209.5-00bfff?logo=linux)
![OS: Ubuntu](https://img.shields.io/badge/OS-Ubuntu-00bfff?logo=ubuntu)

# 📊 **Full Monitoring Stack with Prometheus, Grafana, Alertmanager & Node Exporter**

Welcome to your **plug-and-play monitoring solution**!  
This project brings together some of the most powerful open-source monitoring tools — all running in Docker containers, ready to deploy in minutes. 💡

Whether you're a DevOps engineer, a system admin, or just a curious tinkerer, this stack provides instant visibility into your infrastructure, making it easier to monitor and respond to issues in real time.  

---

### 🚀 **What's Included?**

| Component        | Purpose                                               |
|------------------|--------------------------------------------------------|
| 🔍 **Prometheus**  | Time-series database and monitoring system             |
| 📈 **Grafana**     | Beautiful dashboards for data visualization            |
| 🚨 **Alertmanager**| Handles and routes alerts triggered by Prometheus      |
| 🧠 **Node Exporter**| Collects hardware and OS metrics from the host         |
| 💾 **Backup Service** | Automatic daily backup of Prometheus data            |

Everything is **pre-configured** and ready to run, so you can focus on monitoring your system’s health without any hassle! 🧘‍♂️

---

## 🧾 **Docker Compose File**


Here's the `docker-compose.yml` file you need to get started:

```yaml
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - ./alert_rules.yml:/etc/prometheus/alert.rules.yml
      - prometheus_data:/prometheus
    ports:
      - "9090:9090"
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.enable-lifecycle'

  grafana:
    image: grafana/grafana-oss:latest
    container_name: grafana
    volumes:
      - grafana_data:/var/lib/grafana
      - ./grafana_datasource.yml:/etc/grafana/provisioning/datasources/datasource.yml
      - ./default-dashboard.json:/etc/grafana/provisioning/dashboards/default-dashboard.json
    ports:
      - "3000:3000"

  alertmanager:
    image: quay.io/prometheus/alertmanager:latest
    container_name: alertmanager
    volumes:
      - ./alertmanager.yml:/etc/alertmanager/config.yml
    command:
      - '--config.file=/etc/alertmanager/config.yml'
    ports:
      - "9093:9093"

  node-exporter:
    image: prom/node-exporter:latest
    container_name: node_exporter
    ports:
      - "9100:9100"

  backup:
    image: alpine:latest
    container_name: prometheus_backup
    volumes:
      - prometheus_data:/prometheus
      - ./backups:/backups
    entrypoint: ["/bin/sh", "-c", "while true; do cp -r /prometheus /backups/$(date +%Y%m%d_%H%M%S); sleep 86400; done"]

volumes:
  prometheus_data:
  grafana_data:
```

---
## 🔍 Prometheus | prometheus.yml config : 
```bash
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['node-exporter:9100']

rule_files:
  - "alert_rules.yml"
```
## 🚨 Alertmanager| alert_rules.yml config file : 
```bash
groups:
  - name: example_alert_rules
    rules:
      - alert: HighCPUUsage
        expr: 100 - (avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[1m])) * 100) > 80
        for: 1m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage detected"
          description: "CPU usage is above 80% for more than 1 minute."
```

## 📈 grafana_datasource.yml config file : 
```bash
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
```

##  🚨 alertmanager.yml config file : 
```bash
global:
  smtp_smarthost: 'smtp.protonmail.com:587'
  smtp_from: 'your-alerts@protonmail.com'
  smtp_auth_username: 'your-alerts@protonmail.com'
  smtp_auth_password: 'your-password'  # use secrets in production

route:
  receiver: 'email-alert'

receivers:
  - name: 'email-alert'
    email_configs:
      - to: 'your-email@protonmail.com'
        send_resolved: true
```

## 💾 backup.sh config file : 
```bash
#!/bin/sh
mkdir -p ./backups
cp -r ./prometheus_data ./backups/$(date +%Y%m%d_%H%M%S)
```

## 🛠️ **How to Run (Step-by-Step)**

### 📥 **1. Clone the Repository**
```bash
git clone https://github.com/yourname/monitoring-stack.git
cd monitoring-stack
```

### 🚀 **2. Start All Services**
```bash
docker compose up -d
```

### 📟 **3. Check Logs (Optional)**
```bash
docker compose logs -f
```

### ⛔ **4. Stop All Services**
```bash
docker compose down
```

### ♻️ **5. Restart Services**
```bash
docker compose restart
```

---

## 🌐 **Access Your Services**

| Service        | URL                                |
|----------------|-------------------------------------|
| 🔍 **Prometheus**   | [http://localhost:9090](http://localhost:9090) |
| 📈 **Grafana**      | [http://localhost:3000](http://localhost:3000) |
| 🚨 **Alertmanager** | [http://localhost:9093](http://localhost:9093) |
| 🧠 **Node Exporter**| [http://localhost:9100/metrics](http://localhost:9100/metrics) |

---

## 🔐 **Grafana Login**

- **Username:** `admin`  
- **Password:** `admin`  
(*You’ll be prompted to change the password on first login.*)

---
## 📊 Recommended Dashboards

You can import these from Grafana Dashboards:

    Node Exporter Full: 1860

    Docker Monitoring: 179

    Linux Server Dashboard: 11074

    System Overview: Custom one provided in dashboards/

To add more dashboards, drop the JSON file into the dashboards/ folder and restart Grafana.

---

---

## 💾 Backup System

The backup service copies Prometheus TSDB data every 24 hours into backups/YYYYMMDD_HHMMSS.

You can restore any snapshot simply by stopping the stack and replacing the data:

```bash
docker compose down
cp -r backups/20250420_070000/* prometheus_data/
docker compose up -d``` 
```

## 🧠 **Notes**

- All configurations are preloaded and ready to go.
- Ensure [Docker](https://www.docker.com/) & [Docker Compose](https://docs.docker.com/compose/) are installed on your machine.
- You can easily customize dashboards, rules, or data sources by editing the provided config files.

---

## ✨ **Enjoy effortless monitoring!**

Built for DevOps, SysAdmins, and anyone who loves clean metrics & beautiful dashboards.  
No headaches. Just data. 📊💚
