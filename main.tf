resource "datadog_monitor_json" "this" {
  for_each = { for file in local.monitor_files : trimsuffix(file, ".json.tmpl") => file }
  monitor = templatefile(
    "${path.module}/monitors/${each.value}",
    {
      alert_recipients = var.alert_recipients
    }
  )
}
