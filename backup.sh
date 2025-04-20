#!/bin/sh
mkdir -p ./backups
cp -r ./prometheus_data ./backups/$(date +%Y%m%d_%H%M%S)
