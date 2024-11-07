# AWS Websocket API Terraform module

Terraform module to deploy Websocket API using AWS API Gateway and Python Lambda functions
on websocket connect, disconnect, and send-message events.

[See terraform registry page](https://registry.terraform.io/modules/zmunk/websocket-api/aws/latest)

## Usage
Create three python scripts, one for "connect", one for "disconnect", and one for "sendmessage".
```python
# lambda/websocket_connect
def lambda_handler(event, context):
    conn_id = event["requestContext"]["connectionId"]
    print(f"{conn_id = }")
    return {}
```
```python
# lambda/websocket_disconnect
def lambda_handler(event, context):
    conn_id = event["requestContext"]["connectionId"]
    print(f"{conn_id = }")
    return {}
```
```python
# lambda/websocket_sendmessage
def lambda_handler(event, context):
    conn_id = event["requestContext"]["connectionId"]
    print(f"{conn_id = }")
    print(f"{event.get('body') = }")
    return {}
```
Create your main.tf terraform file.
```terraform
# main.tf
module "websocket_api" {
  source  = "zmunk/websocket-api/aws"
  version = "1.0.0"

  api_name                  = "WebsocketAPI"
  connect_function_path     = "./lambda/websocket_connect"
  disconnect_function_path  = "./lambda/websocket_disconnect"
  sendmessage_function_path = "./lambda/websocket_sendmessage"
}
```
Create your outputs.tf terraform file.
```terraform
# outputs.tf
output "websocket_api_endpoint" {
  description = "Websocket API url"
  value       = module.websocket_api.url
}

output "websocket_connect_lambda_log_group" {
  description = "Log group name of websocket connect function"
  value       = module.websocket_api.connect_lambda_log_group
}

output "websocket_disconnect_lambda_log_group" {
  description = "Log group name of websocket disconnect function"
  value       = module.websocket_api.disconnect_lambda_log_group
}

output "websocket_sendmessage_lambda_log_group" {
  description = "Log group name of websocket sendmessage function"
  value       = module.websocket_api.sendmessage_lambda_log_group
}
```

## Testing
Get your API endpoint url.

    $ tf output websocket_api_endpoint
```python
import json
import websockets.sync.client

API_URL = "<api-endpoint-url>"

socket = websockets.sync.client.connect(API_URL)
print("successfully connected")

socket.send(
    json.dumps(
        {
            "action": "sendmessage",
            "message": "hello",
        }
    )
)

socket.close()
print("successfully disconnected")
```
You should see the following logs from your `sendmessage` function:

    2024-11-07 16:17:41  event.get('body') = '{"action": "sendmessage", "message": "hello"}'
