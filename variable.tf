variable "region" {
    description = "The region in which the resources will deploy "
    default = "ap-south-2"
}

variable "bucket_name" {
    description = "The bucket name  which we will create   "
    default = "deepushivanshforever"
  
}

variable "profile_name" {
     description = "The profile name which it has access to create reasource in aws "
     default = "arati_sdlc"
}