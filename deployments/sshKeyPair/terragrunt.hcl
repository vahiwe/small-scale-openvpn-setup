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
  source = "../../modules/sshKeyPair"
}

inputs = {
  generated_key_name = include.root.inputs.key_pair_name
}