#### connection block
#    - 프로비저너  file과 remote-exec에 필요한 원격지(SSH, WinRM) 연결 정보를 정의한다
#    - 리소스에 선언되면 리소스 내 모든 프로비저너에 공통 적용된다
#      프로비저너 내에 선언되는 경우 헤당 프로비저너에만 적용된다

resource "null_resource" "name" {
  connection {
    type         = "ssh"                 # 연결유형을 지정하며 기본값은 ssh이다(winrm, ssh 가능)
    user         = "root"                # 연결에 사용할 유저의 이름 지정
    password     = self.root_password    # 연결에 사용되는 비밀번호
    private_key  = file("~/.ssh/id_rsa") # ssh연결에 사용할 개인키 파일의 경로. password인수보다 우선한다
    host         = self.public_ip        # IP주소 또는 호스트 이름 지정. 일반적으로 리소스 속성에서 가져옴
    bastion_host = "bastion.example.com" # 배스천 호스트 연결을 활성화한다(관련 인수 추가 지정해야함)
  }

}

