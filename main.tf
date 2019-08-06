data "aws_sns_topic" "topic" {
  name = var.sns-topic
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name = var.name
  statistic = "Maximum"
  comparison_operator = "GreaterThanThreshold"
  threshold = 0
  evaluation_periods = var.evaluation_periods
  datapoints_to_alarm = var.datapoints_to_alarm
  treat_missing_data = "missing"
  period = var.period
  namespace = "AWS/States"
  metric_name = "ExecutionsFailed"

  dimensions = {
    StateMachineArn = var.state-machine-arn
  }

  alarm_actions = [data.aws_sns_topic.topic.arn]

  tags = var.tags
}