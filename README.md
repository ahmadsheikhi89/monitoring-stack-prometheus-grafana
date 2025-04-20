
```markdown
<h1 align="center">Monitoring Stack</h1>

<p align="center">
  A full-featured monitoring stack using <strong>Prometheus</strong>, <strong>Grafana</strong>, <strong>Alertmanager</strong>, and <strong>Node Exporter</strong> — containerized with Docker Compose.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Monitoring-Docker%20Stack-blue?style=flat-square" alt="Monitoring Stack Badge" />
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square" alt="MIT License" />
  <img src="https://img.shields.io/badge/Prometheus-Metrics-red?style=flat-square" />
  <img src="https://img.shields.io/badge/Grafana-Dashboards-orange?style=flat-square" />
</p>

---

## What's Inside?

| Component       | Purpose                                  | Default Port |
|----------------|-------------------------------------------|--------------|
| Prometheus      | Metrics collection & alerting            | `9090`       |
| Grafana         | Dashboards & visualizations              | `3000`       |
| Alertmanager    | Alert routing and notifications          | `9093`       |
| Node Exporter   | System metrics exporter                  | `9100`       |
| Alpine Backup   | Daily backup of Prometheus data          | N/A          |

---

## Project Structure

```bash
.
├── alertmanager.yml               # Alertmanager configuration
├── alert_rules.yml               # Prometheus custom alert rules
├── backups/                      # Prometheus TSDB daily backups
├── backup.sh                     # Manual backup script
├── dashboards/                   # Grafana dashboards (JSON)
├── default-dashboard.json        # Default Grafana dashboard
├── docker-compose.yml            # Docker Compose configuration
├── grafana_datasource.yml        # Grafana datasource provisioning
├── grafana_dashboards.yml        # Grafana dashboard provisioning
└── prometheus.yml                # Prometheus configuration
```

---

## How to Use

### Step 1: Clone the Repository

```bash
git clone https://github.com/your-username/monitoring-stack.git
cd monitoring-stack
```

### Step 2: Start All Services

```bash
docker compose up -d
```

### Step 3: Access Services

- **Grafana:** [http://localhost:3000](http://localhost:3000)  
  **User:** `admin` | **Pass:** `admin`
- **Prometheus:** [http://localhost:9090](http://localhost:9090)
- **Alertmanager:** [http://localhost:9093](http://localhost:9093)
- **Node Exporter:** [http://localhost:9100](http://localhost:9100/metrics)

---

## Health Check

Want to make sure everything is running? Run:

```bash
docker ps
```

You should see all 5 containers running. To confirm service health:

```bash
curl -s localhost:9090/-/healthy
curl -s localhost:3000/api/health
```

If everything is OK, you'll get `{“status”:“ok”}` from Grafana and `Prometheus is Healthy` message.

---

## Custom Dashboards in Grafana

1. Export a dashboard from Grafana as JSON.
2. Put it inside the `dashboards/` folder.
3. Grafana auto-loads dashboards from this directory.

Dashboard provisioning is handled via `grafana_dashboards.yml` and linked on container start.

---

## Backup Strategy (Automated)

An `alpine` container creates **daily backups** of Prometheus TSDB data into the `backups/` folder with a timestamp.

### Want to Backup Now?

Just run:

```bash
./backup.sh
```

Or copy manually inside the container:

```bash
docker exec prometheus_backup sh -c "cp -r /prometheus /backups/$(date +%Y%m%d_%H%M%S)"
```

---

## Stopping the Stack

To stop and remove all services:

```bash
docker compose down
```

---

## Troubleshooting

- Check logs if anything fails:

```bash
docker compose logs -f
```

- If Grafana has no data:
  - Make sure Prometheus target is `UP`
  - Check `grafana_datasource.yml` is correctly mounted

---

## License

This project is licensed under the [MIT License](LICENSE).
```

---

اگه خواستی نسخه Markdown فایل رو هم بهت بدم که مستقیماً توی `README.md` بندازی، فقط بگو. همچنین اگه بج یا بنر شخصی‌سازی شده برای برند خودت خواستی، طراحی‌شو هم می‌تونم انجام بدم.
