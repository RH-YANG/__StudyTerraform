#### dynamic
#    - 리소스 내부 속성요소 중 블록으로 표현되는 부분을 반복시킬 수 있다


# 기존 코드
data "archive_file" "dotfiles" {
  type        = "zip"
  output_path = "${path.module}/dotfiles.zip"

  source {
    content  = "hello a"
    filename = "${path.module}/a.txt"
  }

  source {
    content  = "hello b"
    filename = "${path.module}/b.txt"
  }

  source {
    content  = "hello c"
    filename = "${path.module}/c.txt"
  }
}


# dynamic을 사용한 코드
variable "names" {
  default = {
    a = "hello a"
    b = "hello b"
    c = "hello c"
  }
}

data "archive_file" "dotfiles" { # 아카이브파일(압축파일) 생성하는 블록
  type        = "zip"
  output_path = "${path.module}/dotfiles.zip"

  dynamic "source" {
    for_each = var.names
    content {
      content  = source.value
      filename = "${path.module}/${source.key}.txt"
    }
  }
}
