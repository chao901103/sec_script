#!/bin/bash
# date 2020-11-09
# 小白
# version_1.0

echo -e "请选择对应的项目：
    [1]扫描IP范围:
    	ipcalc
    [2]扫描存活IP,指定I段:
    	nmap -sn
    [3]批量访问http://IP,请指定文件名:
    	whatweb
    [q]退出脚本：	
\033[31m 注:\033[0m 当前目录文件[ ip.txt and url.txt ]文件会被覆盖！
"

read -p "pls input num: " Imp

function Ip(){
    read -p "请输入测试IP段: " I
    ipcalc $I |egrep "(HostMin)|(HostMax)" |awk '{print $1,$2}'
}

function N_map(){
    read -p "请输入IP范围,例(1.1.1.1/23) : " N
    nmap -sn $N |grep for |awk '{print $5}' > ip.txt
    echo "查看当前目录ip.txt文件"
    cat ip.txt
}

function W_Web(){
    read -p "请指定包含IP的文件: " W
    whatweb --no-error --url-prefix="http://" -i $W |egrep "\[202|\[301|\[302" |awk '{print $1,$2}' > http_url.txt
    whatweb --no-error --url-prefix="https://" -i $W |egrep "\[202|\[301|\[302" |awk '{print $1,$2}' > https_url.txt
    echo "查看当前目录url.txt文件"
    cat url.txt
}

#ipcalc $1
#nmap -sv $1 |grep for |awk '{print $5}'
#whatweb -i $1 --no-error --url-prefix="http://"

case ${Imp} in
    "1")
	Ip
    ;;
    "2")
	N_map
    ;;
    "3")
	W_Web
    ;;
    q|Q|quit)
	exit 0
    ;;
    *)
    echo "Are you OK !"
esac
