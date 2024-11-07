# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api
resource "aws_apigatewayv2_api" "this" {
  name                       = var.api_name
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage
resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "v1"
  auto_deploy = true

  depends_on = [
    module.websocket_connect_integration,
    module.websocket_disconnect_integration,
    module.websocket_sendmessage_integration,
  ]
}

module "lambda_websocket_connect" {
  source  = "zmunk/lambda/aws"
  version = "1.0.0"

  function_name = "websocket_connect"
  description   = "Runs when a new client connects to websocket"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  source_path   = var.connect_function_path
}

module "lambda_websocket_disconnect" {
  source  = "zmunk/lambda/aws"
  version = "1.0.0"

  function_name = "websocket_disconnect"
  description   = "Runs when a client disconnects from websocket"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  source_path   = var.disconnect_function_path
}

module "lambda_websocket_sendmessage" {
  source  = "zmunk/lambda/aws"
  version = "1.0.0"

  function_name = "websocket_sendmessage"
  description   = "Runs when a client sends a websocket message"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  source_path   = var.sendmessage_function_path
}

module "websocket_connect_integration" {
  source = "./modules/websocket_api_integration"

  api_id        = aws_apigatewayv2_api.this.id
  route_key     = "$connect"
  function_name = module.lambda_websocket_connect.function_name
  invoke_arn    = module.lambda_websocket_connect.invoke_arn
}

module "websocket_disconnect_integration" {
  source = "./modules/websocket_api_integration"

  api_id        = aws_apigatewayv2_api.this.id
  route_key     = "$disconnect"
  function_name = module.lambda_websocket_disconnect.function_name
  invoke_arn    = module.lambda_websocket_disconnect.invoke_arn
}

module "websocket_sendmessage_integration" {
  source = "./modules/websocket_api_integration"

  api_id        = aws_apigatewayv2_api.this.id
  route_key     = "sendmessage"
  function_name = module.lambda_websocket_sendmessage.function_name
  invoke_arn    = module.lambda_websocket_sendmessage.invoke_arn
}
