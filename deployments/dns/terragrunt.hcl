include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

include "version" {
  path = find_in_parent_folders("version.hcl")
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../modules/dns"
}

dependency "vpn_server" {
  config_path = "../ec2"

  mock_outputs_allowed_terraform_commands = ["validate", "plan", "state", "destroy"]
  mock_outputs_merge_strategy_with_state  = "shallow"
  mock_outputs = {
    ip_address = "127.0.0.1"
  }
}


inputs = {
  domain_name     = include.root.inputs.domain_name
  subdomain       = include.root.inputs.subdomain
  server_ip       = dependency.vpn_server.outputs.ip_address
  source_root_dir = include.root.inputs.source_root_dir
}