data "aws_sns_topic" "topic" {
  name = var.sns-topic
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name = var.name
  statistic = "SampleCount"
  comparison_operator = "GreaterThanThreshold"
  threshold = 0
  evaluation_periods = 1
  datapoints_to_alarm = 1
  treat_missing_data = "notBreaching"
  period = var.period
  namespace = "AWS/States"
  metric_name = "ExecutionsFailed"

  dimensions = {
    StateMachineArn = var.state-machine-arn
  }

  alarm_actions = [data.aws_sns_topic.topic.arn]

  tags = var.tags
}