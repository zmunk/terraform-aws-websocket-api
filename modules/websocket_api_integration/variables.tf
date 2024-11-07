variable "api_id" {
  description = "api gateway id"
  type        = string
}

variable "route_key" {
  description = "api gateway route key"
  type        = string
}

variable "function_name" {
  description = "lambda function name"
  type        = string
}

variable "invoke_arn" {
  description = "lambda function invoke arn"
  type        = string
}
