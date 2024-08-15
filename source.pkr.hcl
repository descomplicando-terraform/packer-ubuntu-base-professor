locals {
  image_id = var.release != "" ? var.release : formatdate("YYYYMMDDhhmmss", timestamp())
}

data "amazon-ami" "ubuntu" {
  filters = {
    virtualization-type = "hvm"
    name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
    root-device-type    = "ebs"
  }
  owners      = ["099720109477"]
  most_recent = true
  region      = "us-east-1"
}

source "amazon-ebs" "imagem-base" {
  ssh_username  = var.user
  instance_type = "t3.micro"
  region        = "us-east-1"
  ami_name      = replace("base-${local.image_id}", ".", "-")
  tags = {
    OS_Version    = "Ubuntu"
    Release       = "${local.image_id}"
    Base_AMI_Name = "{{ .SourceAMIName }}"
    Extra         = "{{ .SourceAMITags.TagName }}"
  }

  //ami_regions = ["us-east-2", "us-west-2"]
  source_ami           = data.amazon-ami.ubuntu.id
}