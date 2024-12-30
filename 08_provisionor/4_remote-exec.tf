#### 프로비저너 remote-exec
#    - 원격지 환경에서 실행할 커맨드와 스크립트를 정의한다


#### 주요속성
#    * 다음 중 한개만 사용한다
#    - incline  : []로 명령어를 묶어서 지정
#    - script : 로컬의 스크립트 경로를 입력(원격에 복사해 실행한다)
#    - scripts : 스크립트 경로를 []로 묶어서 다수 지정


# 사용예
# 단순히 script 만으로 스크립트 실행한 필요한 인수는 선언할 수 없으므로 file프로비저너를 활용한다
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  key_name      = "my-key"

  connection {
    type        = "ssh"
    user        = "root"
    private_key = self.password
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args"
    ]


  }
}
