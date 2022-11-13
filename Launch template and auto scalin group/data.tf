 data "template_file" "this" {
  template = file("${path.module}/userdata.tpl")
 }
  
 data "template_cloudinit_config" "this" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "userdata.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.this.rendered
  }
 }
