آفرین احمد! خیلی خوبه که فایل‌ها رو آماده و آپلود کردی. الان می‌خوام یه نسخه‌ی کامل‌تر از `README.md` برات بنویسم که همه‌ی موارد ضروری رو شامل بشه — مثل:

- ساختار فایل‌ها و دایرکتوری‌ها  
- توضیح دقیق هر فایل  
- توضیح کامل سرویس‌های Docker Compose  
- نحوه‌ی استفاده از بکاپ  
- چک‌ هلث  
- و نکات حرفه‌ای که برای هر DevOps حتی اگر "گاو بود" هم قابل فهم باشه 😄

---

📄 **فایل کامل README.md پروژه Monitoring Stack**

```markdown
# 🖥️ Monitoring Stack with Prometheus + Grafana + Alertmanager

A professional, easy-to-deploy monitoring stack for Linux servers and Dockerized applications using Prometheus, Grafana, and Alertmanager.

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Docker Compose](https://img.shields.io/badge/Docker--Compose-v3.8-blue)

---

## 📁 Project Structure

```
monitoring-stack/
├── alertmanager.yml              # Alertmanager configuration
├── alert_rules.yml               # Prometheus alert rules
├── backup.sh                     # Prometheus backup script (runs every 24h)
├── backups/                      # Backup directory (auto-created)
├── dashboards/                   # JSON Grafana dashboards
│   └── system-overview.json      # Example dashboard file
├── grafana_dashboards.yml        # Dashboard provisioning config
├── grafana_datasource.yml        # Prometheus datasource config for Grafana
├── prometheus.yml                # Prometheus main configuration
├── docker-compose.yml            # All services defined here
└── README.md                     # You're here now
```

---

## 🚀 Quick Start

### 🧰 Requirements

- Docker 🐳
- Docker Compose 📦

### 🛠️ Setup Instructions

1. **Clone the project**
   ```bash
   git clone https://github.com/yourname/monitoring-stack.git
   cd monitoring-stack
   ```

2. **Pull all Docker images**
   ```bash
   docker compose pull
   ```

3. **Start the stack**
   ```bash
   docker compose up -d
   ```

4. **Access Grafana**
   - URL: [http://localhost:3000](http://localhost:3000)
   - Default user: `admin`
   - Default pass: `admin` (you will be asked to change it)

---

## 🐳 Docker Compose Services

### 🔹 Prometheus
- Port: `9090`
- Config: `prometheus.yml`
- Alert Rules: `alert_rules.yml`

### 🔹 Grafana
- Port: `3000`
- Auto-provisions:
  - **Datasource:** Prometheus
  - **Dashboards:** From `dashboards/` folder

### 🔹 Alertmanager
- Port: `9093`
- Config: `alertmanager.yml`

### 🔹 Node Exporter
- Port: `9100`
- Monitors host metrics (CPU, memory, disk, etc.)

### 🔹 Prometheus Backup Service
- Image: `alpine`
- Runs `backup.sh`
- Saves daily snapshots in `backups/` folder
- Automatically timestamps folders

---

## 💾 Backup System

The backup service copies Prometheus TSDB data every 24 hours into `backups/YYYYMMDD_HHMMSS`.

You can restore any snapshot simply by stopping the stack and replacing the data:

```bash
docker compose down
cp -r backups/20250420_070000/* prometheus_data/
docker compose up -d
```

---

## ❤️ Health Check (Manual)

Although healthcheck isn’t implemented via Docker's native `healthcheck`, here are ways to test:

- Grafana: `curl http://localhost:3000/api/health`
- Prometheus: `curl http://localhost:9090/-/ready`
- Alertmanager: `curl http://localhost:9093/-/ready`

For scripting healthchecks or monitoring, you can implement external probes or use tools like Blackbox Exporter.

---

## 📊 Recommended Dashboards

You can import these from [Grafana Dashboards](https://grafana.com/grafana/dashboards/):

- **Node Exporter Full**: `1860`
- **Docker Monitoring**: `179`
- **Linux Server Dashboard**: `11074`
- **System Overview**: Custom one provided in `dashboards/`

To add more dashboards, drop the JSON file into the `dashboards/` folder and restart Grafana.

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).

---

## 💡 Tip for DevOps

- You don’t need to be a Prometheus/Grafana guru.
- The stack works out-of-the-box.
- All configs are mounted so you can change without rebuilding.

For custom setups, just tweak and `docker compose restart`.

Enjoy monitoring like a pro 🚀
```

---

اگه تأییدش کردی، می‌تونم همینو به‌صورت فایل `README.md` هم برات آپلود کنم تا مستقیم بذاری تو ریشه پروژه‌ت. آماده‌اش کنم؟
