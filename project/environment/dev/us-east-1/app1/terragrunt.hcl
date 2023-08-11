include "root"{
  path = find_in_parent_folders("common.hcl")
}

terraform {
    source="tfr://gitlab.com/karaminejad/infra/aws//modules/app1?version=0.0.8"
    extra_arguments "custom_vars" {
    commands = [
      "init",
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]
    required_var_files = ["${get_parent_terragrunt_dir()}/configuration/${basename(dirname(dirname(get_terragrunt_dir())))}/${basename(dirname(get_terragrunt_dir()))}/${basename(get_terragrunt_dir())}/app1.tfvars"]
    
  }
}


dependency "network" {
     config_path = "../network"
}

inputs = {
   app_subnet_id = dependency.network.outputs.private_subnets_id
}

