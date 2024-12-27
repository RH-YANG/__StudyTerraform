#### local-exec




variable "sensitive_content" {
  default   = "secret"
  sensitive = true
}

resource "local_file" "foo" {
  content  = upper(var.sensitive_content)
  filename = "${path.module}/foo.bar"

  # 리소스가 생성 된 이후 아래 프로비저너가 순차적으로 수행된다.

  provisioner "local-exec" {
    command = "echo The content is ${self.content}" # 민감한 정보라서 출력이 거부된다.
  }

  provisioner "local-exec" {
    command    = "abc"    # 실패하는 명령어이다
    on_failure = continue # 계속해서 진행하게 된다
  }

  provisioner "local-exec" {
    when    = destroy # 테라폼 destroy때 실행된다
    command = "echo The deleting filename is ${self.filename}"
  }
}
