#### 프로비저너 file
#    - 테라폼을 실행하는 시스템에서 연결 대상으로 파일/디렉토리를 복사하는데 사용


#### 주요 속성
#    - source : 로컬의 원본 소스파일 또는 디렉토리 (content와 중복사용 불가)
#    - content : 연결대상에 복사할 내용을 문자열로 지정
#    - destination : 원격 서버에 저장될 경로 (절대경로로 지정)


# 사용예
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  key_name      = "my-key"

  # 로컬의 myfile.txt 파일을 원격 서버의 /tmp/myfile.txt 경로로 복사
  provisioner "file" {
    source      = "myfile.txt"
    destination = "/tmp/myfile.txt"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
