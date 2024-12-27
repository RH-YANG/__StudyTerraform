# count에 지정된 정수 갯수만큼 리소스/모듈을 생성한다

#### 접근하기
#    - 반복되는 순서 : count.index
#    - 생성되는 리소스 : 리소스타입.이름[인덱스]
#    - 생성되는 모듈 : module.이름[인덱스]


resource "local_file" "abc" {
  count   = 5
  content = "abc"
  # filename = "${path.module}/abc.txt" 이렇게 정의하면 덮어써져서 결과적으로는 1개만 생성된다.
  filename = "${path.module}/abc${count.index}.txt"
}
