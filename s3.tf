resource "aws_s3_bucket" "s3bucket" {
    bucket = var.bucket_name
    
}

resource "aws_s3_bucket_versioning" "s3bucket" {
  bucket = aws_s3_bucket.s3bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3bucket" {
    bucket = aws_s3_bucket.s3bucket.id
    rule {
      object_ownership = "BucketOwnerPreferred"
    }
  
}

resource "aws_s3_bucket_public_access_block" "s3bucket" {
    bucket = aws_s3_bucket.s3bucket.id
    
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
  
}

resource "aws_s3_bucket_acl" "s3bucket" {
    depends_on = [ 
        aws_s3_bucket_ownership_controls.s3bucket,
        aws_s3_bucket_public_access_block.s3bucket,
     ]
     bucket = aws_s3_bucket.s3bucket.id
     acl = "public-read"
  
}

resource "aws_s3_object" "index" {
    bucket   = aws_s3_bucket.s3bucket.id
    key      = "index.html"
    source   = "index.html"
    acl      = "public-read"
    content_type = "text/html"
}

resource "aws_s3_object" "error" {
    bucket   = aws_s3_bucket.s3bucket.id
    key      = "error.html"
    source   = "error.html"
    acl      = "public-read"
    content_type = "text/html"
}

resource "aws_s3_object" "cartoon" {
    bucket   = aws_s3_bucket.s3bucket.id
    key      = "cartoon.png"
    source   = "cartoon.png"
    acl      = "public-read"
}

resource "aws_s3_bucket_website_configuration" "s3bucket" {
   bucket = aws_s3_bucket.s3bucket.id
   index_document {
     suffix = "index.html"
   }
   
   error_document {
     key = "error.html"
   }

   routing_rule {
     condition {
       key_prefix_equals = "docs/"
     }
     redirect {
       replace_key_prefix_with = "documents/"
     }
   }
}