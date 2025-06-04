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
