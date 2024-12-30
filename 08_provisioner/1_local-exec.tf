#### 프로비저너 local-exec 
#    - 테라폼이 실행되는 환경에서 수행할 커맨드를 정의
#    - OS 환경에 맞게 정의해야한다

#### 주요 속성
#    - command : 실행할 명령어. 필수값. <<연산자를 사용해서 여러줄 커맨드 입력 가능
#    - working_dir : 명령어 실행 위치 지정
#    - interpreter : 명령어를 실행할 인터프리터 및 인수값을 지정한다
#                    기본값은 운영체제의 기본 쉘 (/bin/sh 또는 cmd.exe)
#    - environment : 명령어 실행 시 사용할 환경 변수들을 설정


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
