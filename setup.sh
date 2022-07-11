#!/bin/bash

# apm 설치 함수
apm_setting() { 
    sudo apt update & sudo apt upgrade 

    # apache2, php, mysql 설치
    sudo apt install apache2 php php-mysql mysql-server -y

    # apache2 실행
    sudo service apache2 start
}