variable "region" {
  description = "aws region"
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "vpc cidr"
  default     = "10.0.0.0/16"
}

variable "vpc_tenancy" {
  description = "vpc tenancy status"
  default     = "default"
}

variable "vpc_dns" {
  description = "dns support status"
  default     = true
}

variable "Prod-pub-sub1_cidr" {
  description = "public subnet cidr 1"
  default     = "10.0.1.0/24"
}

variable "Prod-pub-sub2_cidr" {
  description = "public subnet cidr 2"
  default     = "10.0.2.0/24"
}

variable "Prod-priv-sub1_cidr" {
  description = "private subnet cidr 1"
  default     = "10.0.3.0/24"
}

variable "Prod-priv-sub2_cidr" {
  description = "private subnet cidr 2"
  default     = "10.0.4.0/24"
}
