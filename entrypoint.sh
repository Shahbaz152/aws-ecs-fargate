#!/bin/bash
# 🚨 Intentionally vulnerable script for SonarCloud Quality Gate testing

# Hardcoded sensitive values
DB_USER="admin"
DB_PASS="password123"  # SonarCloud rule: hardcoded password

# Unused variables
foo="bar"

# Dangerous eval use
eval "echo PWNED"

# Backticks (discouraged)
current_time=`date`

# World-writable permissions
chmod 777 /etc/passwd

# Sudo in script (in container usually fails, but flagged)
sudo ls

# Useless subshell
echo $(echo "Double subshell")

# Start Apache
apachectl -D FOREGROUND
