
#### list 자료형에 for 사용하기
variable "names" {
  type    = list(string)
  default = ["a", "b"]
}

# 파라미터를 1개만 받는다면 값이 담긴다
output "A_upper_value" {
  value = [for v in var.names : upper(v)]
}

# 파라미터를 2개 받는다면 첫번째에는 인덱스가 두번째에는 값이 담긴다
output "B_index_and_value" {
  value = [for i, v in var.names : "${i} is ${v}"]
}

# {}로 감싸면 object를 반환한다
output "C_make_object" {
  value = { for v in var.names : v => upper(v) }
}

# []로 감싸면 tuple을 반환한다
output "D_with_filter" {
  value = [for v in var.names : upper(v) if v != "a"]
}


#### map 자료형에 for 사용하기
variable "members" {
  type = map(object({
    role = string
  }))
  default = {
    ab = { role = "member", group = "dev" }
    cd = { role = "admin", group = "dev" }
    ef = { role = "member", group = "ops" }
  }
}

output "A_to_tupple" {
  value = [for k, v in var.members : "${k} is ${v.role}"]
}

# if 구문을 추가하 조건을 부여할 수 있다.
output "B_get_only_role" {
  value = {
    for name, user in var.members : name => user.role
    if user.role == "admin"
  }
}

# ...를 붙이면 키의 중복을 방지한다
output "C_group" {
  value = {
    for name, user in var.members : user.role => name...
  }
}
