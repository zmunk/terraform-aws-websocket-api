output "url" {
  description = "Websocket API url"
  value       = aws_apigatewayv2_stage.this.invoke_url
}

output "connect_lambda_log_group" {
  description = "Log group name of websocket connect function"
  value       = module.lambda_websocket_connect.log_group_name
}

output "disconnect_lambda_log_group" {
  description = "Log group name of websocket disconnect function"
  value       = module.lambda_websocket_disconnect.log_group_name
}

output "sendmessage_lambda_log_group" {
  description = "Log group name of websocket sendmessage function"
  value       = module.lambda_websocket_sendmessage.log_group_name
}

output "connect_lambda_iam_role_name" {
  description = "IAM role name of websocket connect function"
  value       = module.lambda_websocket_connect.role_name
}

output "disconnect_lambda_iam_role_name" {
  description = "IAM role name of websocket disconnect function"
  value       = module.lambda_websocket_disconnect.role_name
}

output "sendmessage_lambda_iam_role_name" {
  description = "IAM role name of websocket sendmessage function"
  value       = module.lambda_websocket_sendmessage.role_name
}

output "connections_table_name" {
  description = "Name of connections dynamodb table"
  value       = aws_dynamodb_table.connections.name
}

output "connections_table_arn" {
  description = "ARN of connections dynamodb table"
  value       = aws_dynamodb_table.connections.arn
}

output "websocket_connection_handler_policy_arn" {
  description = "ARN of IAM policy that allows handling API connections"
  value       = aws_iam_policy.websocket_connection_handler_policy.arn
}
