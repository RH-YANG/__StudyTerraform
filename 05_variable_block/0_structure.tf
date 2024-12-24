#### 입력 변수 (Input Variable) 블록
#    - 최종 실행 계획(Plan)전에 입력받아 인프라를 구성하는데 사용되는 변수
#    - 변수를 분리해 코드의 변경 없이 여러 인프라를 생성할 수 있게 한다

# variavles.tf 코드 예시
variable "region" {
  description = "AWS 리전"
  type        = string
  default     = "us-west-1" # 외부에서 입력을 받지 않으면 기본값으로 지정된다.
}
# 방법1) plan 또는 apply 명령 시 입력
#    - 1-a) 터미널 입력창에서 입력하기
#    - 1-b) 플래그로 처음부터 입력하기 : terraform apply -var="region=ap-northeast-2"
# 방법2) terraform.tfvars 파일을 통해 전달:
#     - region = "ap-northeast-2"
# 방법3) 환경 변수로 전달
#     - export TF_VAR_region="ap-northeast-2"



#### 1. 구조
#     variable "이름" {
#       <메타인수> = <값>
#     } 

#    - 이름은 동일 모듈 내 모든 변수 선언에서 고유해야한다.
#    - 참조 방법 : var.<이름>



#### 2. 메타인수 종류
#    - description : 목적이나 용도를 설명
#    - type : 변수의 데이터 타입을 지정
#             string, number, bool, list, map, object, tuple, any 등이 가능
#    - default : 외부에서 값을 입력받지 않을 경우 사용할 기본값
#    - validation : 입력 변수의 값에 대해 추가적인 유효성 검사
#             map 형태로 condition과 error_message를 입력한다
#            블록 외부의 값(data 블록 등)을 사용할 수 있다.
#    - sensitive : 변수 값이 출력되거나 로깅되지 않도록 민감 정보로 취급 (기본 false)
#             단, tfstate 파일에는 평문으로 기록되므로 해당 파일 보안에 유의해야한다. 
#    - nullable : 변수에 값이 없어도 됨을 지정 (기본 true)



#### 3. 타입 종류별 선언 방법

variable "string" {
  type        = string
  description = "var String"
  default     = "myString"
}

variable "number" {
  type    = number
  default = 123
}

variable "boolean" {
  default = true
}

variable "list" {
  default = [
    "google",
    "vmware",
    "amazon",
    "microsoft"
  ]
}

output "list_index_0" {
  value = var.list.0
}

output "list_all" {
  value = [
    for name in var.list : upper(name)
  ]
}

variable "map" { # 정렬이 진행됨
  default = {
    aws   = "amazon",
    azure = "microsoft",
    gcp   = "google"
  }
}

variable "set" { # 리스트와 다르게 정렬이 진행된다.
  type = set(string)
  default = [
    "google",
    "vmware",
    "amazon",
    "microsoft"
  ]
}

variable "object" {
  type = object({ name = string, age = number })
  default = {
    name = "abc"
    age  = 12
  }
}

variable "tuple" {
  type    = tuple([string, number, bool])
  default = ["abc", 123, true]
}

variable "ingress_rules" { # optional ( >= terraform 1.3.0)
  type = list(object({
    port        = number,
    description = optional(string),
    protocol    = optional(string, "tcp"),
  }))
  default = [
    { port = 80, description = "web" },
  { port = 53, protocol = "udp" }]
}
