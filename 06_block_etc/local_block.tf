#### local 블록
#    - 값을 재사용하기 위해 정의된 로컬 변수들을 집합으로 표현할 수 있다.



#### 1. 구조
#     local {
#        키 = 값
#        키 = 값
#        ...
#     } 

#    - 동일 모듈 안에서는 다른 파일에서도 참조가 가능하다(단, 파편화 주의)
#    - 참조 방법 : local.<이름>
