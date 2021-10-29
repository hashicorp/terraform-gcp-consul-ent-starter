#!/usr/bin/env bash
set -e -o pipefail

# install package

curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-releases-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-releases-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp-releases.list
apt-get update
apt-get install -y consul-enterprise=${consul_version}+ent jq

echo "Configuring system time"
timedatectl set-timezone UTC

# removing any default installation files from /opt/consul/tls/
rm -rf /opt/consul/tls/*

# /opt/consul/tls should be readable by all users of the system
mkdir /opt/consul/tls
chmod 0755 /opt/consul/tls

touch /opt/consul/tls/consul-ca.pem
chown consul:consul /opt/consul/tls/consul-ca.pem
chmod 0640 /opt/consul/tls/consul-ca.pem

printf "%s" "${ca_cert}" > /opt/consul/tls/consul-ca.pem

gsutil cp "gs://${gcs_bucket_consul_license}/${consul_license_name}" /opt/consul/consul.hclic
# consul.hclic should be readable by the consul group only
chown root:consul /opt/consul/consul.hclic
chmod 0640 /opt/consul/consul.hclic

gossip_encryption_key=$(gcloud secrets versions access latest --secret=${gossip_secret_id})

%{ if acl_client_secret_id != null }acl_tokens=$(gcloud secrets versions access latest --secret=${acl_client_secret_id})%{ endif }

cat << EOF > /etc/consul.d/consul.hcl
ca_file                = "/opt/consul/tls/consul-ca.pem"
data_dir               = "/opt/consul/data"
encrypt                = "$gossip_encryption_key"
license_path           = "/opt/consul/consul.hclic"
server                 = false
verify_incoming        = true
verify_outgoing        = true
verify_server_hostname = true
retry_join = [
  "provider=gce tag_value=${resource_name_prefix}-consul",
]

acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
%{ if acl_client_secret_id != null }
  tokens {
    $acl_tokens
  }
%{ endif }
}

auto_encrypt = {
  tls = true
}

ports {
  https = 8501
}

EOF

# consul.hcl should be readable by the consul group only
chown root:root /etc/consul.d
chown root:consul /etc/consul.d/consul.hcl
chmod 640 /etc/consul.d/consul.hcl

systemctl enable consul
systemctl start consul
