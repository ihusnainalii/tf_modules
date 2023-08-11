include "root"{
  path = find_in_parent_folders("common.hcl")
}
terraform {
    #source="../../..//modules/network"
    #source="tfr://gitlab.com/karaminejad/infra/aws//modules/network?version=0.0.8"
    source="git::https://github.com/mkaraminejad/tf_modules.git//modules/network?ref=v0.0.2"
    
    extra_arguments "custom_vars" {
    commands = [
      "init",
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]
    required_var_files = ["${get_parent_terragrunt_dir()}/configuration/${basename(dirname(dirname(get_terragrunt_dir())))}/${basename(dirname(get_terragrunt_dir()))}/${basename(get_terragrunt_dir())}/network.tfvars"]
    
  }

}
