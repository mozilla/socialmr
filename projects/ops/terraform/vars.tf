variable "env" {
  description = "VPC environment (prod, qa, etc)"
}

variable "cidr" {
  description = "CIDR for VPC"
  default = "10.0.0.0/16"
}

variable "public_ranges" {
  description = "Comma separated public CIDRs for VPC"
  default = "10.0.0.0/24,10.0.2.0/24"
}

variable "private_ranges" {
  description = "Comma separated private CIDRs for VPC"
  default = "10.0.1.0/24,10.0.3.0/24"
}

variable "azs" {
  description = "Comma separated AZs for VPC"
  default = "us-west-1b,us-west-1c"
}

variable "ret_http_port" {
  description = "Reticulum HTTP service listener port"
  default = 4000
}

variable "ret_webrtc_port" {
  description = "Reticulum WebRTC service listener port"
  default = 5000
}
