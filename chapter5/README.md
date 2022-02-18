# Chapter 5

create 3 unique accounts with count 
```
resource "aws_iam_user" "example" { 
    count = 3
    name = "neo.${count.index}"
}
```

create 3 unique accounts with count an variables
```
variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}
```

create the 3 accounts with a for_each
```
variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.key
}
```

for_each with dynamic
variable
```
variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
}
```

main.tf
```
  dynamic "tag" {
    for_each = var.custom_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
```

for option to output all in capital using a list
```
variable "names" {
    description = "A list of names"
    type = list(string)
    default = ["neo", "trinity", "morpheus"]
}
    
output "upper_names" {
    value = [for name in var.names : upper(name)]
}
```

output all in capital but only where the characters are less than 5
```
variable "names" {
    description = "A list of names"
    type = list(string)
    default = ["neo", "trinity", "morpheus"]
}
    
output "upper_names" {
    value = [for name in var.names : upper(name) if length(name) < 4]
}
```


for option to output all in capital using a map
```
variable "hero_thousand_faces" { 
    description = "map"
    type = map(string)
    default = {
      neo = "hero"
      trinity  = "love interest"
      morpheus = "mentor"
    }
}

output "bios" {
    value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}
```
output
```
bios = [
      "morpheus is the mentor",
      "neo is the hero",
      "trinity is the love interest",
]
```

output to map a map with upper
```
variable "hero_thousand_faces" { 
    description = "map"
    type = map(string)
    default = {
      neo = "hero"
      trinity  = "love interest"
      morpheus = "mentor"
    }
}

output "upper_roles" {
    value = {for name, role in var.hero_thousand_faces : upper(name) => upper(role)}
}
```

Dynamic inline block
```
  variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
}



  dynamic "tag" {
    for_each = var.custom_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
```

true or false with variables and count

```
variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" { count = var.enable_autoscaling ? 1 : 0
      scheduled_action_name  = "${var.cluster_name}-scale-out-during-business-hours"
  min_size
  max_size
  desired_capacity
  recurrence
  autoscaling_group_name = aws_autoscaling_group.example.name
}

```

only create the resource of the instance type starts with t like t2.micro
```
resource "aws_cloudwatch_metric_alarm" "low_cpu_credit_balance" { 
  count = format("%.1s", var.instance_type) == "t" ? 1 : 0
```

conditional if string directive
```
variable "name" {
    description = "A name to render" 
    type = string
    default=""
}
 
output "if_else_directive" {
    value = "Hello, %{ if var.name != "" }${var.name}%{ else }(unnamed)%{ endif }"
}
```
output
```
if_else_directive = Hello, (unnamed)
```