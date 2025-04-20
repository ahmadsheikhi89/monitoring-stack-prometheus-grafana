
```markdown
# 🚀 Monitoring Stack with Prometheus, Grafana, Alertmanager & Node Exporter

یک استک کامل برای مانیتورینگ سیستم با استفاده از Docker Compose.
کامل کانفیگ شده، بدون نیاز به هیچ کار اضافه. فقط اجرا کن و لذت ببر!

---

## 📦 فایل `docker-compose.yml`

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

## 🛠️ دستورات موردنیاز

قدم‌به‌قدم و بدون دردسر:

### 1. کلون پروژه
```bash
git clone https://github.com/yourname/monitoring-stack.git
cd monitoring-stack
```

### 2. اجرای پروژه (اولین بار)
```bash
docker compose up -d
```

> تمام سرویس‌ها (Prometheus, Grafana, Alertmanager, Node Exporter, Backup) با هم بالا میان.

### 3. دیدن لاگ سرویس‌ها (اختیاری)
```bash
docker compose logs -f
```

### 4. استاپ و خاموش کردن سرویس‌ها
```bash
docker compose down
```

### 5. ریستارت سرویس‌ها (مثلاً بعد از تغییر تنظیمات)
```bash
docker compose restart
```

---

## 🌐 دسترسی به سرویس‌ها

| سرویس         | آدرس دسترسی                     |
|---------------|-----------------------------------|
| Prometheus    | [http://localhost:9090](http://localhost:9090) |
| Grafana       | [http://localhost:3000](http://localhost:3000) |
| Alertmanager  | [http://localhost:9093](http://localhost:9093) |
| Node Exporter | [http://localhost:9100/metrics](http://localhost:9100/metrics) |

---

## 📈 یوزر و پسورد Grafana

- **Username:** `admin`
- **Password:** `admin` (در اولین ورود از شما خواسته میشه تغییرش بدین)

---

## ⚡ نکته نهایی

> تمام سرویس‌ها و تنظیمات از قبل آماده شده‌اند.
> فقط کافیست Docker و Docker Compose روی سیستم شما نصب باشد.
> به‌سادگی می‌توانید با تغییر فایل‌های YAML موجود، سرویس‌ها را به دلخواه خود شخصی‌سازی کنید.

---
