wazuh/certs/indexer_cluster/generate_certs.sh
wazuh/certs/dashboard_http/generate_certs.sh
kubectl apply -k envs/local-env/

tee -a /home/ubuntu/other/wazuh-service.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  name: internet-wazuh-dashboard
  namespace: wazuh
spec:
  type: NodePort
  selector:
    app: wazuh-dashboard
  ports:
    - port: 443         # Port exposed by the service
      targetPort: 443   # Port on the pod
      protocol: TCP
      nodePort: 30002   # Optional: Kubernetes will assign if not specified
EOF

k apply -f /home/ubuntu/other/wazuh-service.yaml

