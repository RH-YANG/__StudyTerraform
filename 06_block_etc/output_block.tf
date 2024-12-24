#### output 블록
#    - 모듈의 출력 값을 정의하는 데 사용
#    - terraform apply시, 정의된 output 값들이 콘솔에 출력된다.(sensitive제외)
#    - 모듈 내에서 출력된 값은 module.<module_name>.<output_name> 형식으로 다른 모듈에서 참조할 수 있다.
#    - terraform output으로 해당 값들만 따로 출력할 수 있다.
#      >> 특정 output값만 출력하거나 -raw로 순수 값만 출력할 수 있음



#### 1. 구조
#     output "<output_name>" {
#       value = <expression>
#       description = "<description>"
#       sensitive = <true|false>
#     }



#### 2. 출력 시기

# 단순 값은 plan에서 변경사항으로 값이 출력된다.
output "example_output" {
  value = "This is a static value"
}

# 리소스 생성 이후에 확정되는 값은 apply시에만 확정된 값을 볼 수 있다.
resource "local_file" "abc" {
  content  = "abc123"
  filename = "${path.module}/abc.txt"
}

output "file_id" {
  value = local_file.abc.id
}

# 다만 출력을 예측할 수 있는 경우에는 plan에서도 출력된다.
output "file_abspath" {
  value = abspath(local_file.abc.filename)
}
