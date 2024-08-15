variable "user" {
  type        = string
  description = "Usuário default"
  default     = "ubuntu"
}

variable "release" {
  type        = string
  description = "Release tag do CICD pipeline"
  default     = ""
}