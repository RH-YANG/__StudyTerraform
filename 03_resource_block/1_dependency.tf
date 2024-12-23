

#### 특징1. 리소스 블록은 프로바이더에 종속성을 갖는다

#    - 아래 리소스를 선언한 후 init을 하면 프로바이더를 정의하지 않아도 자동으로 aws가 초기화된다
resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
}



#### 특징2. 다른 리소스 값을 참조하면 자동적으로 암시적 종속성을 갖게된다.

resource "local_file" "abc" {
  content  = "123!"
  filename = "${path.module}/abc.txt"
}

resource "local_file" "def" { # 종속성이 없어서 병렬로 진행되는 경우
  content  = "456!"
  filename = "${path.module}/def.txt"
}

resource "local_file" "ghi" {       # 자동으로 종속성이 생기는 경우
  content  = local_file.abc.content # 이부분 때문에 "ghi"는 "abc"가 생성된 이후 생성된다
  filename = "${path.module}/ghi.txt"
}

resource "local_file" "jkl" { # 명시적으로 종속성을 지정하는 경우
  depends_on = [
    local_file.ghi
  ]
  content  = "456!"
  filename = "${path.module}/jkl.txt"
}

#### 종속성 가시화하기
#     1. VSCode 확장팩 설치 : Graphviz Interactive Preview
#     2. terraform graph로 종속성 데이터 복사
#     3. graph.dot 파일로 저장
#     4. 오른 상단의 'dot'버튼 클릭 또는 명령어 팔레트(Ctrl + Shift + P)에서 Graphviz Interactive 검색 및 클릭 
