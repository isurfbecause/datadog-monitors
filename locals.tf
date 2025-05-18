locals {
  monitor_files = fileset("${path.module}/monitors", "*.json.tmpl")
}
