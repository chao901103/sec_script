#!/bin/bash

subDomainsBrute="/root/me/tools/farmscan_domain/subDomainsBrute/"
dirsearch="/root/me/dir_scan/dirsearch/"
oneforall="/root/me/tools/OneForAll/"

echo "请输入数字选择项目 
	1 查询子域名,工具subDomainsBrute; 
	2 查看子域名下的文件,工具dirsearch
	3 查询子域名，并生成csv文件，工具Oneforall
	4 扫描端口，工具nmap
	q 退出脚本
	"

read -p "Pls is num: " num
case $num in
	1) echo "请输入主域名"
	read -p "pls is domain: " domain
	#echo  ${subDomainsBrute}subDomainsBrute.py $domain 
	cd ${subDomainsBrute}
	/usr/bin/python2 subDomainsBrute.py $domain 
	echo "结果 ${subDomainsBrute}${domain}.txt"
	;;
	2) echo "请输入要子域名"
	read -p "pls is subdom: " subdom
	cd ${dirsearch}
	/usr/bin/python3 dirsearch.py -u $subdom -E 
	echo "结果 ${dirsearch}reports/${subdom}"
	;;
	3) echo "请输入主域名"
	read -p "pls is domain csv: " csv
	cd ${oneforall}
	/usr/bin/python3 oneforall.py --target $csv --format csv run
	echo "结果 ${oneforall}results"
	;;
	4) echo "请输入IPv4"
	read -p "pls is IPV4: " IPV4
	/usr/bin/nmap -Pn $IPV4 > ${IPV4}.txt
	echo "结果 ${IPV4}.txt"
	;;
	q|Q)# echo "请输入（q || Q）退出"
	exit 0
	;;
	*) echo "Are you ok?"
	exit 1
esac
