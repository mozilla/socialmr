terragrunt = {
  terraform {
    source = "git::git@github.com:mozilla/socialmr.git//ops/terraform/modules/ret"
  }

  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../vpc"]
  }
}

ret_http_port = 4000
ret_webrtc_port = 4000
