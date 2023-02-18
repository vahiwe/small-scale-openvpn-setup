#!/bin/bash -xe
EMAIL_LINK="test@test.com"
DOMAIN_LINK="${domain_name}"

# Stop openvpn
sudo /usr/local/openvpn_as/scripts/sacli stop

# These are the OpenVPN AS command-line customizations. From within the instance or using the AWS Run Command you can see what is set by using the command: /usr/local/openvpn_as/scripts/sacli ConfigQuery
sudo /usr/local/openvpn_as/scripts/sacli --key vpn.client.tls_version_min --value 1.2 ConfigPut
sudo /usr/local/openvpn_as/scripts/sacli --key vpn.client.tls_version_min_strict --value true ConfigPut
sudo /usr/local/openvpn_as/scripts/sacli --key vpn.server.tls_version_min --value 1.2 ConfigPut
sudo /usr/local/openvpn_as/scripts/sacli --key cs.tls_version_min --value 1.2 ConfigPut
sudo /usr/local/openvpn_as/scripts/sacli --key cs.tls_version_min_strict --value true ConfigPut

# OpenVPN AS supported ciphers listed here: https://openvpn.net/index.php/access-server/docs/admin-guides/437-how-to-change-the-cipher-in-openvpn-access-server.html
sudo /usr/local/openvpn_as/scripts/sacli --key vpn.client.config_text --value 'cipher AES-256-CBC' ConfigPut
sudo /usr/local/openvpn_as/scripts/sacli --key vpn.server.config_text --value 'cipher AES-256-CBC' ConfigPut

# This setting got me an A on Qualys SSL Labs. Dicpher string codes here, ! means remove: https://www.openssl.org/docs/man1.0.2/apps/ciphers.html
sudo /usr/local/openvpn_as/scripts/sacli -k cs.openssl_ciphersuites -v 'DEFAULT:!EXP:!PSK:!SRP:!RC4:!RSA:!3DES' ConfigPut

# Changes require a restart.
sudo /usr/local/openvpn_as/scripts/sacli start

# Get ssl certificate
# open port 80 for verifying ssl certificate
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot || true # if you get an error here, it's ok
sudo certbot certonly --debug --non-interactive --preferred-challenges http --email $EMAIL_LINK --agree-tos --standalone --domains $DOMAIN_LINK --keep-until-expiring --pre-hook 'sudo service openvpnas stop' --post-hook 'sudo service openvpnas start'

# sudo /usr/local/openvpn_as/scripts/sacli stop
sudo /usr/local/openvpn_as/scripts/confdba -mk cs.ca_bundle -v "`sudo cat /etc/letsencrypt/live/$DOMAIN_LINK/fullchain.pem`"
sudo /usr/local/openvpn_as/scripts/confdba -mk cs.priv_key -v "`sudo cat /etc/letsencrypt/live/$DOMAIN_LINK/privkey.pem`" > /dev/null
sudo /usr/local/openvpn_as/scripts/confdba -mk cs.cert -v "`sudo cat /etc/letsencrypt/live/$DOMAIN_LINK/cert.pem`"
sudo /usr/local/openvpn_as/scripts/sacli start