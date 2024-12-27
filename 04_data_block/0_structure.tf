#### 데이터 블록
#    - 테라폼으로 정의되지 않은 외부 리소스 또는 저장된 정보를 테라폼 내에서 참조할 때 사용한다
#    - Terraform 실행 중에 생성되거나 정의된 데이터를 조회하거나 가공할 때도 사용


####  1. 구조
#    - 데이터 소스 유형에서 프로바이더와 리소스 유형을 확인할 수 있다.

#     data "프로바이더_리소스유형" "필요한경우 식별용 이름" {
#       <인수> = <값>
#     } 

# 예시
data "local_file" "abc" {
  filename = "${path.module}/abc.txt"
}


#### 2. 참조하기
#    - 리소스 블록과 구별되게 앞에 data가 붙는다
#    - data.리소스유형.이름.속성


#### 3. 활용예 : aws 프로바이더
data "aws_availability_zones" "available" {
  state = "available" # 'available' 상태인 가용 영역만 가져옴
}

# resource "aws_subnet" "primary" {
#   ...
#   availability_zone = data.aws_availability_zones.available.names[0]
#   ...
# }


#### 4. 활용예 : local 프로바이더
resource "local_file" "abc" {
  content  = "123!"
  filename = "${path.module}/abc.txt"
}

data "local_file" "abc" {
  filename = local_file.abc.filename
}

resource "local_file" "def" {
  content  = data.local_file.abc.content
  filename = "${path.module}/def.txt"
}
