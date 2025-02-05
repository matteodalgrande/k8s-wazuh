#!/bin/bash
set -e

echo "Starting Wazuh Agent Setup..."

# Ensure that the 'wazuh' group exists, and create it if it doesn't
if ! getent group wazuh >/dev/null; then
    echo "Creating group 'wazuh'..."
    groupadd -r wazuh
fi

# Ensure that the 'wazuh' user exists, and create it if it doesn't
if ! id -u wazuh >/dev/null 2>&1; then
    echo "Creating user 'wazuh'..."
    useradd -r -g wazuh -d /var/ossec -s /bin/false wazuh
fi

# Ensure proper ownership on /var/ossec and subdirectories
find /var/ossec -path /var/ossec/etc/authd.pass -prune -o -exec chown wazuh:wazuh {} +

# Set execute permissions on the binary, if not already set.
if [ -f "/var/ossec/bin/wazuh-control" ]; then
    chmod +x /var/ossec/bin/wazuh-control
fi

# Check if Wazuh is already installed
if [ ! -f "/var/ossec/bin/wazuh-control" ]; then
    echo "Wazuh agent not found. Installing..."
    apt update && \
    JOIN_MANAGER_API_PORT="55000" WAZUH_MANAGER="wazuh-workers.wazuh.svc.cluster.local" WAZUH_MANAGER_PORT="1514" WAZUH_REGISTRATION_SERVER="wazuh.wazuh.svc.cluster.local" WAZUH_REGISTRATION_PORT="1515" WAZUH_REGISTRATION_PASSWORD="password" apt install -y wazuh-agent=4.10.1-1

    # Ensure the authentication password is set
    if [ -f "/var/ossec/etc/authd.pass" ]; then
        echo "Using provided authd.pass from secret."
    else
        echo "Error: authd.pass file is missing!"
        exit 1
    fi
else
    echo "Wazuh agent is already installed. Skipping installation."
fi

# Start Wazuh agent
echo "Starting Wazuh Agent..."
JOIN_MANAGER_API_PORT="55000" WAZUH_MANAGER="wazuh-workers.wazuh.svc.cluster.local" WAZUH_MANAGER_PORT="1514" WAZUH_REGISTRATION_SERVER="wazuh.wazuh.svc.cluster.local" WAZUH_REGISTRATION_PORT="1515" WAZUH_REGISTRATION_PASSWORD="password" /var/ossec/bin/wazuh-control start
# su -s /bin/bash -c "/var/ossec/bin/wazuh-control start" wazuh

# Keep container running and show logs
tail -f /var/ossec/logs/ossec.log
