## Network Speed Monitor
This is an automatic provisioning of the [network speed monitor](https://pimylifeup.com/raspberry-pi-internet-speed-monitor/).
The speed monitor uses a cron job to run a python script every 30 mins. The script checks the speed of the network and writes the findings to an InfluxDB which is fed to Grafana for visualization.

Grafana is automatically provisioned with a dashboard:

![GrafanaDashboard](screenshots/dashboard.png)