# Use the slim image of Node.js version 16
FROM ubuntu:latest
RUN apt update && \
    apt install -y gcc curl gpg

RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list \
    && apt-get update
    # WAZUH_MANAGER="wazuh-workers.wazuh.svc.cluster.local" WAZUH_MANAGER_PORT="1514" WAZUH_REGISTRATION_SERVER="wazuh.wazuh.svc.cluster.local" WAZUH_REGISTRATION_PORT="1515" WAZUH_REGISTRATION_PASSWORD="password" apt install -y wazuh-agent=4.10.1-1

    # apt-cache madison wazuh-agent
   
# Set up the working directory
WORKDIR /var/ossec

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the entrypoint script to install Wazuh at runtime
ENTRYPOINT ["/entrypoint.sh"]

# CMD ["/bin/bash", "-c", "tail -f /dev/null"]

# apt update && \
#     apt install -y gcc curl gpg
# curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg \
#     && echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list \
#     && apt-get update \
#     && WAZUH_MANAGER="wazuh-workers.wazuh.svc.cluster.local" WAZUH_MANAGER_PORT="1514" WAZUH_REGISTRATION_SERVER="wazuh.wazuh.svc.cluster.local" WAZUH_REGISTRATION_PORT="1515" WAZUH_REGISTRATION_PASSWORD="password" apt install -y wazuh-agent=4.10.1-1

#     WAZUH_MANAGER="wazuh.wazuh.svc.cluster.local"
# sed -i "s|MANAGER_IP|$WAZUH_MANAGER|g" /var/ossec/etc/ossec.conf
# echo "password" > /var/ossec/etc/authd.pass

# apt install nano
# /var/ossec/bin/wazuh-control start

# cat /var/ossec/logs/ossec.log 

# /var/ossec/bin/wazuh-control start
# /var/ossec/bin/wazuh-control status


# nc -zv wazuh.wazuh.svc.cluster.local 55000
# nc -zv wazuh.wazuh.svc.cluster.local 1515

# echo "password" > /var/ossec/etc/authd.pass
# cat /var/ossec/logs/ossec.log 

# <address>192.168.19.150:5500</address>
# <address>wazuh.wazuh.svc.cluster.local</address>

# clusterIP: 10.97.188.176
# clusterIPs:

# - 10.97.188.176
#   - name: registration
#     nodePort: 31424
#     port: 1515
#     protocol: TCP
#     targetPort: 1515
# - name: api
# nodePort: 32200
# port: 55000
# protocol: TCP
# targetPort: 55000


#################
# Manager
################
# "password" > /var/ossec/etc/authd.pass
# /var/ossec/bin/wazuh-control restart
