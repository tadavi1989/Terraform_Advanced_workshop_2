// ??? whole file
variable "instance_type" {
  description = "instance type for workshop-app instances"
  default = "t2.micro"
}

variable "ami" {
  description = "ami id for workshop-app instances"
  default = "ami-0817d428a6fb68645"
}

variable "role" {
	default = "workshop-app-wrapper"
}

variable "cluster_name" {
	default = "workshop-terraform"
}

variable "workshop-app_cluster_size_min" {
  
}

variable "workshop-app_cluster_size_max" {
  
}

variable "additional_sgs" {
  default = ""
}

variable "terraform_bucket" {
  default = "workshop-tf-state"
  description = <<EOS
S3 bucket with the remote state of the site module.
The site module is a required dependency of this module
EOS

}

variable "site_module_state_path" {
  default = "workshop-site-state/terraform.tfstate"
  description = <<EOS
S3 path to the remote state of the site module.
The site module is a required dependency of this module
EOS

}

variable web-app {
  
} 
