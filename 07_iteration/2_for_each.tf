#### for_eaxh
#    - for_each에 지정된 원소 갯수만큼 리소스/모듈을 생성한다
#    - 자료형태는 list, set, map등이 가능하다.
#    - list는 중간에 요소가 삭제되면 이후 순번이 바뀌면서 다른 리소스로 취급된다.
#      set은 중간에 요소가 삭제되어 순서가 바뀌어도 동일한 리소스로 취급한다. 


# 직접적으로 map을 명시하는 케이스
resource "local_file" "abc" {
  for_each = {
    a = "content a"
    b = "content b"
  }
  content  = each.value
  filename = "${path.module}/${each.key}.txt"
}


variable "names" {
  default = {
    a = "content a"
    b = "content b"
    c = "content c"
  }
}

# 외부에서 map을 가져오는 케이스
resource "local_file" "abc" {
  for_each = var.names
  content  = each.value                           # 값에 접근하는 방법확인 
  filename = "${path.module}/abc-${each.key}.txt" # 키에 접근하는 방법 확인
}


resource "local_file" "def" {
  for_each = local_file.abc # map 형태를 반환하므로 for_each에 쓸 수 있다.
  content  = each.value.content
  filename = "${path.module}/def-${each.key}.txt"
}
