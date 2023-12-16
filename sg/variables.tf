variable "ingressrules" {
    type = list(number)
    default = [80,443,22]
}

variable "egressrules" {
    type = list(number)
    default = [80,443,22]
}

variable "ingressrules_database" {
    type = list(number)
    default = [80,443,22,19530,8000]
}

variable "egressrules_database" {
    type = list(number)
    default = [80,443,22,19530,8000]
}
