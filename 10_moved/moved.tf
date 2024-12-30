#### moved 블록
#    - 테라폼 1.1부터 지원
#    - 이름은 변경되지만 이미 테라폼으로 프로비저닝된 환경을 그대로 유지하고자 할때 사용


# 1. 하단의 리소스를 먼저 apply한다.
# resource "local_file" "a" {
#   content  = "foo!"
#   filename = "${path.module}/foo.bar"
# }


# 2. 위 리소스를 아래와 같이 변경하면 plan 시 리소스 삭제 후 새로 생성하게 된다
resource "local_file" "b" {
  content  = "foo!"
  filename = "${path.module}/foo.bar"
}


# 3. 삭제를 원하지 않는다면 moved블록을 추가해준다
#    기존의 프로비저닝은 유지한 채 이름만 바꾼다
moved {
  from = local_file.a
  to   = local_file.b
}

# 4. b를 참조하는 해당 명령어가 가능해진다
output "file_content" {
  value = local_file.b.content
}
