#!/bin/bash

# yes 혹은 no 선택하는 함수 (받는 값을 그대로 사용해도 무방하나, 여러 가능성을 고려해 작성함)
__check__() {
    case $1 in
    Yes|YES|yes|y|Y)
        echo 1
        ;;
    No|NO|no|N|n)
        echo 2
        ;;
    *)
        echo 3
    esac
}

# apm 설치 함수
apm_setting() { 
    sudo apt update & sudo apt upgrade 

    # apache2, php, mysql 설치
    sudo apt install apache2 php php-mysql mysql-server -y

    # apache2 실행
    sudo service apache2 start
}

# github 연동
__github__() {
    # /var/www/html의 파일들을 날릴 수 있다는 경고 문구 삽입 및 확인
    read -p "[warning] /var/www/html 경로를 덮어씌우게 됩니다! 계속 진행하겠습니까? (yes, no): " cover
    
    # 사용자의 선택
    cover_ans=$(__check__ $cover)

    if [ $cover_ans -eq 1 ]
    then
        # html 폴더 삭제
        sudo rm -rf /var/www/html

        # .git 주소 받아오기
        read -p ".git address: " git_addr

        # /var/www/html로 git clone
        sudo git clone $git_addr /var/www/html

        # github 계정 저장 여부
        read -p "github 계정을 저장하겠습니까? (yes, no): " store

        # 사용자의 선택
        store_ans=$(__check__ $store)

        if [ $store_ans -eq 1 ]
        then
            # github credential 정보 저장
            cd /var/www/html
            sudo git config credential.helper store
        
        fi
        
    elif [ $cover_ans -eq 2 ]
    then
        # 취소 메시지 출력
        echo "cancel"
    
    else
        # 잘못된 입력 출력
        echo "Invalid"
    
    fi
}