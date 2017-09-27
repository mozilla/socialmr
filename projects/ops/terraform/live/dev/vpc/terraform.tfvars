terragrunt = {
  terraform {
    source = "git::git@github.com:mozilla/socialmr.git//ops/terraform/modules/vpc#ops/provisioning"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}

cidr = "10.0.0.0/16"
public_ranges = "10.0.0.0/24,10.0.2.0/24"
private_ranges = "10.0.1.0/24,10.0.3.0/24"
