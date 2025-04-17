#!/bin/bash
# 🧨 Insecure script to intentionally fail SonarCloud analysis

echo "Starting Apache..."
export SECRET_KEY="supersecret"  # hardcoded secret

# Unused variable
UNUSED="never used"

# Using eval — considered bad practice
eval "echo Hello from eval"

# This could be flagged by linters / scanners
chmod 777 /var/www/html

# Start apache (normal)
apachectl -D FOREGROUND
