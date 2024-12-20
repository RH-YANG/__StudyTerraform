#### 테라폼 블럭 역할 1 : 버전을 명시한다 

terraform {

  #### 1. 테라폼 버전 명시하기
  required_version = ">= 1.0.0"
  # required_version = "< 1.0.0"  init시 오류남 : 설치된 버전과 맞지 않음

  #### 2. 프로바이더 버전 명시하기
  required_providers {
    # 다양한 프로바이더들의 버전을 나열한다
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # 가용 불가능한 버전시 init에서 오류가 남
    }
  }

}
