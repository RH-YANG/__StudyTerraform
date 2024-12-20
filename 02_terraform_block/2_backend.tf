#### 테라폼 블럭 역할 2 : 백엔드 블록을 통해 상태파일을 관리한다


# 테라폼 상태파일
#    - 기본 파일명 : terraform.tfstate
#    - 관리 중인 인프라 리소스의 현재 상태를 기록
#    - 현재 상태와 상태 파일을 비교 후 plan을 생성
#    - 리소스 간의 종속성 관계를 추적하여 작업 순서 결정


# 백앤드 블록이란?
#    - 상태 파일을 저장하고 관리하는 방법과 위치를 정의한다
#    - 공유되는 폴더에서 관리될 경우 테라폼이 실행되는동안 다른 사용자가 실행하지 못하도록 lock 파일이 생성된다.
#    - 기본적으로 하나의 백엔드만 사용 가능하다(필요시 전환)


# 백앤드 유형
#    - local : 로컬 파일 시스템에 저장
#    - s3: Amazon S3에 상태 파일 저장.
#    - remote: Terraform Cloud나 Terraform Enterprise와 같은 원격 환경에 상태 파일 저장.
#    - http: HTTP 서버를 통해 상태 파일 관리.


#### 예제1 : 현재 pc에 백엔드를 설정하는 경우
terraform {
  backend "local" {
    path = "state/terraform.tfstate" # 루트 디렉토리 하위로 새로운 폴더를 지정한다
  }
}


#### 예제2 : S3 유형으로 백엔드를 설정하는 경우
# terraform {

#   backend "s3" {
#     bucket         = "my-terraform-state"
#     key            = "path/to/my/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-lock"
#   }

# }
