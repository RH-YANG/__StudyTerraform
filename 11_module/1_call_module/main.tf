#### 모듈 사용 방법
#    - module이 선언되면 init 후에 .terraform/modules/modules.json 파일이 생긴다
#      >> 모듈의 메타데이터가 저장된다
#    - 모듈 소스코드의 위치가 로컬이 아닌 경우 init시 .terraform/modules 하위로 코드가 다운로드된다.
#    - 모듈 참조 방식 : module.모듈이름.output이름
#  

# 1. 코드작성
module "mypw1" { # 자식모듈을 호출한다
  source = "../modules/terraform-random-pwgen"
}

module "mypw2" {
  source = "../modules/terraform-random-pwgen"
  isDB   = true
}


output "mypw1" {
  value = module.mypw1
}

output "mypw2" {
  value = module.mypw2
}


# 2. 테스트
#    - terraform init & terraform apply


# 3. 출력 결과 확인
#     mypw1 = {
#       "id" = "immortal-scorpion"
#       "pw" = "qRASROvHa7"
#     }
#     mypw2 = {
#       "id" = "better-pheasant"
#       "pw" = "ApT%eXCnK*kTdJ36"
#     }
#  >> mypw2는 isDB가 true인 케이스의 비밀번호가 생성된것을 확인할 수 있다
