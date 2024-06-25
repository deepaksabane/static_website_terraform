variable "region" {
    description = "The region in which the resources will deploy "
    type = string  
}

variable "bucket_name" {
    description = "The bucket name  which we will create   "
    type = string
  
}

variable "profile_name" {
     description = "The profile name which it has access to create reasource in aws "
     type = string
}