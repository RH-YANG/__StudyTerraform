#### 0. 파일 작성하기
resource "local_file" "abc" {
  content  = "abc!"
  filename = "${path.module}/abc.txt"
}

#    - 프로바이더 local_file 
#      >> 로컬 파일 시스템에 텍스트 파일을 생성, 업데이트, 삭제할 수 있다

#    - ${}
#      >> 표현식을 감싸 동적으로 값을 반환
#      >> 문자열 내부로 값을 입력하고자 할 때 사용한다

#    - ${path.module}
#      >> 실행되는 테라폼 모듈(디렉토리 단위)의 절대경로


#### 1. 초기화하기 : terraform init
#     >> .terraform 폴더와 .terraform.lock.hcl 파일이 생성된다.
#     >> 초기화를 번복하려면 생성된 폴더와 파일을 삭제하면 된다(외부 캐시에 저장하지 않음)

#    - .terraform.lock.hcl
#     >> 프로바이더 종속성을 고정시키는 역할
#     >> 해당 파일이 있으면 이를 기준으로 init을 수행한다
#     >> 개인 프로젝트인경우 깃이그노어에 등록하는것이 낫다

#    - terraform init -upgrade
#     >> lock 파일을 무시하고 tf파일 내 정의된 제약 조건 내에서 최신 프로바이더 버전을 다운로드


#### 2. 유효성 검사 : terraform validate
#     >> 코드적인 유효성 검토
#     >> 원격작업이나 API 호출 없음

#    - 4번째 줄 코드를 주석하고 명령어를 실행해본다.


#### 3. 실행계획 생성 : terraform plan
#      >> 어떤 변경이 적용될지 사용자가 미리 검토할 수 있다.

#    - terraform plan -detailed-exitcode
#      >> echo $? 명령어를 통해 결과를 0,1,2로 받을 수 있다(61페이지)

#    - terraform plan -out=파일명
#      >> 계획을 파일로 생성하여 apply 명령시 승인여부를 묻지 않도록 한다
#      >> 파일이 생성된 이후 다른 변경사항이 실행된 경우 해당 파일은 사용할 수 없게 된다.

#    - terraform plan -destroy -out=파일명

#### 4. 실행 : terraform apply
#      >> 계획을 기반으로 작업을 실행한다.
#      >> terraform.tfstate 파일이 생성된다.
#      >> 계획이 지정되지 않은 경우 계획을 생성하고 승인여부를 묻는다
#      >> -auto-approve 옵션을 통해 승인과정을 생략할 수 있다.

#    - terraform apply 파일명
#      >> 해당 실행파일을 기준으로 작업 진행
#      >> 승인여부를 전달할 필요가 없다.

#    - terraform apply -replace=리소스경로
#      >> 변경사항이 없더라도 삭제 후 재생성한다.

#    - terraform.tfstate.backup
#      >> 추가적인 실행으로 변경사항이 생긴경우 생성되는 파일


#### 5. 테라폼 리소스 확인 : terraform state list
#      >> Terraform 상태 파일에 의해 관리되는 모든 리소스 목록 출력
#      >> resource_type.resource_name 형식으로 표시


#### 6. 테라폼 리소스 삭제 : terraform destroy
#      >> 현재 Terraform 상태 파일에 의해 관리되는 모든 리소스를 삭제

#    - terraform plan 파일명
#      >> destroy 플랜을 가진 파일을 생성한 뒤 plan 명령어로 승인과정이 없는 처리가 가능하다



