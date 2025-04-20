![Banner]([https://raw.githubusercontent.com/ahmadsheikhi89/gitlab-runner-docker-setup/main](https://github.com/ahmadsheikhi89/monitoring-stack-prometheus-grafana/edit/main/banner.png)

# 📊 Full Monitoring Stack with Prometheus, Grafana, Alertmanager & Node Exporter

Welcome to your **plug-and-play monitoring solution**!  
This project brings together some of the most powerful open-source monitoring tools — all running in Docker containers, ready in minutes. 💡

Whether you're a DevOps engineer, a system admin, or just a curious tinkerer — this stack gives you instant visibility into your infrastructure.  

---

### 🚀 What's Included?

| Component        | Purpose                                               |
|------------------|--------------------------------------------------------|
| 🔍 Prometheus     | Time-series database and monitoring system             |
| 📈 Grafana        | Beautiful dashboards for data visualization            |
| 🚨 Alertmanager   | Handles and routes alerts triggered by Prometheus      |
| 🧠 Node Exporter  | Collects hardware and OS metrics from the host         |
| 💾 Backup Service | Automatic daily backup of Prometheus data             |

Everything is **pre-configured**, so you can just run it and focus on what matters — your system’s health! 🧘‍♂️

---

## 🧾 Docker Compose File


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

## 🛠️ How to Run (Step-by-Step)

### 📥 1. Clone the Repository
```bash
git clone https://github.com/yourname/monitoring-stack.git
cd monitoring-stack
```

### 🚀 2. Start All Services
```bash
docker compose up -d
```

### 📟 3. Check Logs (Optional)
```bash
docker compose logs -f
```

### ⛔ 4. Stop All Services
```bash
docker compose down
```

### ♻️ 5. Restart Services
```bash
docker compose restart
```

---

## 🌐 Access Your Services

| Service        | URL                                |
|----------------|-------------------------------------|
| 🔍 Prometheus   | [http://localhost:9090](http://localhost:9090) |
| 📈 Grafana      | [http://localhost:3000](http://localhost:3000) |
| 🚨 Alertmanager | [http://localhost:9093](http://localhost:9093) |
| 🧠 Node Exporter| [http://localhost:9100/metrics](http://localhost:9100/metrics) |

---

## 🔐 Grafana Login

- **Username:** `admin`  
- **Password:** `admin`  
(*You’ll be prompted to change the password on first login.*)

---

## 🧠 Notes

- All configurations are preloaded and ready to go.
- Make sure [Docker](https://www.docker.com/) & [Docker Compose](https://docs.docker.com/compose/) are installed on your machine.
- You can easily customize the dashboards, rules, or data sources by editing the provided config files.

---

## ✨ Enjoy effortless monitoring!

Built for DevOps, SysAdmins, and anyone who loves clean metrics & beautiful dashboards.  
No headaches. Just data. 📊💚
```
