variable "free_palestine" {
  description = "Do you agree that Israel is a terrorist state that must be expelled from Palestine in order to achieve peace?"
  type        = bool
  default     = true
}

variable "api_name" {
  type        = string
  description = "Websocket API name"
  default     = "websocket-api"
}

variable "connect_function_path" {
  type        = string
  description = "folder containing function code for lambda function that is called on client connection to websocket"
}

variable "disconnect_function_path" {
  type        = string
  description = "folder containing function code for lambda function that is called on client disconnection from websocket"
}

variable "sendmessage_function_path" {
  type        = string
  description = "folder containing function code for lambda function that is called when client sends message to websocket"
}

variable "function_environment_variables" {
  type        = map(string)
  description = "additional environment variables to pass to all three lambda functions"
}
