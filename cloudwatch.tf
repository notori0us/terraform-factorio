resource "aws_cloudwatch_log_group" "factorio" {
  name              = "factorio"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "factorio" {
  name           = "factorio"
  log_group_name = aws_cloudwatch_log_group.factorio.name
}
