#### lifecycle 인수
#    - 리소스의 수명주기를 작업자가 의도적으로 변경할 수 있게 하는 메타인수이다.


## 0. 테스트를 위한 기본 값
resource "local_file" "abc" {
  content  = "lifecycle - step 1" # 최초 값
  filename = "${path.module}/abc.txt"
}



## 1. create_before_destroy
#    - 테라폼은 기본적으로 삭제 후 생성임
#    - 해당 인수를 true로 하면 새로운 리소스를 먼저 생성하고 기존 리소스를 삭제함
resource "local_file" "abc" {
  content  = "lifecycle - step 2" # 수정 발생
  filename = "${path.module}/abc.txt"

  lifecycle {
    create_before_destroy = true
  }
}

## 2. prevent_destroy
#    - 삭제가 일어나지 않게 해 작업을 실패시킨다.
resource "local_file" "abc" {
  content  = "lifecycle - step 3" # 수정 발생
  filename = "${path.module}/abc.txt"

  lifecycle {
    prevent_destroy = true # 해당 코드로 인해 위 수정은 일어나지 않는다.
  }
}


## 3. ignore_changes
#    - 리스트에 담긴 인수의 수정사항을 무시하도록 한다.
#    - 모든 수정을 무시하고자 한다면 all을 입력한다.
resource "local_file" "abc" {
  content  = "lifecycle - step 5" # 수정 발생
  filename = "${path.module}/abc.txt"

  lifecycle {
    ignore_changes = [
      content
    ]
  }
}


## 4. precondition
#    - 리소스 생성 이전에 인수값을 검증하는데 사용된다
#    - 조건이 맞지 않는 경우 에러가 발생하면서 수정이 진행되지 않는다.
variable "file_name" {
  default = "step0.txt"
}

resource "local_file" "abc" {
  content  = "lifecycle - step 6" # 수정 발생
  filename = "${path.module}/${var.file_name}"

  lifecycle {
    precondition {
      condition     = var.file_name == "step6.txt"
      error_message = "file name is not \"step6.txt\""
    }
  }
}


## 5. postcondition
#    - 프로비저닝 변경 이후 결과를 검증한다
#    - 오류가 발생한 경우 변경을 취소시켜 의존성을 갖는 다른 구성의 변경을 막는 효과가 있다.
resource "local_file" "step7" {
  content  = ""
  filename = "${path.module}/step7.txt"

  lifecycle {
    postcondition {
      condition     = self.content != ""
      error_message = "content cannot empty"
    }
  }
}

output "step7_content" { # 위 구문에서 에러가 발생하여 해당 출력은진행되지 않는다.
  value = local_file.step7.id
}
