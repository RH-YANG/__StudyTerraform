#### 테라폼 모듈
#    - 모듈의 이름은 terraform-<프로바이더>-<모듈이름>의 형식을 따른다(권장)
#    - 루트 모듈 하위에 둘 경우 복잡한 코드를 분리하는 용도로 명시되어 종속성이 발생
#      > 루트 모듈 상위에서 별도의 디렉토리를 구성한다



# 1. 모듈 작성하기
#    - 현재 모듈은 이름과 암호를 자동으로 생성해주는 기능을 가지고 있다
#    - random 프로바이더를 사용하고 있다

resource "random_pet" "name" { # 무작위의 동물 기반 이름을 생성한다
  keepers = {
    ami_id = timestamp()
  }
}

resource "random_password" "password" { # 비밀번호를 자동으로 생성한다
  length           = var.isDB ? 16 : 10
  special          = var.isDB ? true : false
  override_special = "!#$%*?"
}


# 2. 테스트
#    - terraform init
#    - terraform apply -auto-approve -var=isDB=true
#    - 생성된 id와 pw의 출력을 확인한다
