# Monitoring Stack

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A minimal and extensible monitoring stack using **Docker Compose**, featuring:

- Prometheus for metrics collection
- Grafana for visualization
- Node Exporter for system metrics
- Alertmanager for notifications
- Daily Prometheus backups

---

## Features

- Metrics collection with Prometheus
- Pre-configured Grafana with dashboards and Prometheus datasource
- Alerting via Alertmanager with sample alert rules
- Daily backups of Prometheus data using a lightweight Alpine container
- Node Exporter to monitor system-level metrics

---

## Requirements

- Docker
- Docker Compose

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-username/monitoring-stack.git
cd monitoring-stack
```

### 2. Directory Structure

```
monitoring-stack/
├── alertmanager.yml
├── alert_rules.yml
├── backup.sh
├── backups/                  # Daily backups go here
├── dashboards/               # Custom Grafana dashboards in JSON format
├── default-dashboard.json    # Default dashboard
├── docker-compose.yml
├── grafana_datasource.yml
├── grafana_dashboards.yml    # Grafana dashboards provisioner config
├── prometheus.yml
└── README.md
```

### 3. Run the stack

```bash
docker-compose up -d
```

- Grafana: [http://localhost:3000](http://localhost:3000)
- Prometheus: [http://localhost:9090](http://localhost:9090)
- Alertmanager: [http://localhost:9093](http://localhost:9093)
- Node Exporter: [http://localhost:9100](http://localhost:9100)

---

## Health Check

You can verify all services are running properly with:

```bash
docker ps
```

Ensure containers for `prometheus`, `grafana`, `node_exporter`, `alertmanager`, and `prometheus_backup` are listed and in the "Up" state.

---

## Backup System

Prometheus data is backed up daily via the `backup` service (based on Alpine). Backups are stored in the `backups/` folder, timestamped by date.

To verify backup:

```bash
ls backups/
```

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Notes

- Modify the alert rules in `alert_rules.yml` as needed.
- You can add more dashboards in JSON format inside the `dashboards/` directory.
- Grafana provisioning automatically loads the default dashboard and datasource.

---

## Credits

Built by engineers who love visibility and automation.
