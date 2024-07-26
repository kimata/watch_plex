sudo install -m 0644 -t /etc/systemd/system/ service/reload_plex.service
sudo install -m 0755 -t /usr/local/bin src/reload_plex.sh

sudo systemctl enable reload_plex.service
sudo systemctl start reload_plex.service




