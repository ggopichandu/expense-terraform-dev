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
<<<<<<< HEAD
=======

variable "zone_name" {
    default = "gopichand.online"
  
}
>>>>>>> f988435 (expense-dev)
