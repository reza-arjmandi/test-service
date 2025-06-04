sudo systemctl stop com.Workpuls.service
sudo systemctl disable com.Workpuls.service
sleep 5
sudo rm -rf /usr/lib/Workpuls/
sudo rm -rf /var/log/Workpuls/
sudo rm /lib/systemd/system/com.Workpuls.service
sudo systemctl daemon-reload
