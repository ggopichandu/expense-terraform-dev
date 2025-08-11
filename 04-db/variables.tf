variable "project_name" {
    default = "expense"
  
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
  
}

variable "db_sg_discription" {
    default = "SG for DB MySQL Instances"
  
}


variable "zone_id" {
    default = "Z05089881SMV5BSCETO2M"
}

variable "domain_name" {
    default = "gopichand.online"
}