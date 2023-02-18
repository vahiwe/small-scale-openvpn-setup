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
  source = "../../modules/ec2"
}

dependency "ssh_key" {
  config_path = "../sshKeyPair"

  mock_outputs_allowed_terraform_commands = ["validate", "plan", "state", "destroy"]
  mock_outputs_merge_strategy_with_state  = "shallow"
  mock_outputs = {
    key_pair_name = "test-key-pair"
  }
}


inputs = {
  key_name              = dependency.ssh_key.outputs.key_pair_name
  instance_type         = include.root.inputs.instance_type
  ami_alias             = include.root.inputs.ami_alias
  server_ports_protocol = include.root.inputs.server_ports_protocol
}