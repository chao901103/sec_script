#!/bin/bash
#20201025
#v01

set -e 
## 变量
S_dir="/opt/soft/"
E_dir="/opt/end/"
if [ ! -d  ${S_dir} ];then
    mkdir ${S_dir}
fi
if [ ! -d   ${E_dir} ];then
    mkdir ${E_dir}
fi


echo -e "
\033[31m此脚本包含以下软件：\033[0m  \033[33m
    子域名爆破：
	msubDomainsBrute(sub) --> 字典爆破子域名
	sublist3r --> 互联网扫描子域名
	teemo --> 互联网扫描邮箱
	ksubdomain(ks)  -->  
	q or Q  --> 退出      \033[0m  "
read -p "请选择对应的软件: " imp


################# subdomainsBrute #####################################
function subdomainsBrute(){
	subdomainsBrute_dir="${S_dir}subDomainsBrute/"
	
	if [ -d ${subdomainsBrute_dir} ];then
	    echo ""
	else
	    cd ${S_dir}
	    git clone https://github.com/lijiejie/subDomainsBrute.git
	fi

	cd ${subdomainsBrute_dir}
	read -p "请输入主域名: " domain
	if [ -e ${E_dir}${domain} ];then
	    rm -rf ${E_dir}${domain}
	fi	
        mkdir ${E_dir}${domain}	
	/usr/bin/python2 subDomainsBrute.py $domain  > /dev/null
	mv ${subdomainsBrute_dir}${domain}.txt ${E_dir}${domain}
	echo "结果：${E_dir}${domain}"
}

################# Sublist3r #####################################
function sublist3(){
	sublist3r_dir="${S_dir}Sublist3r/"
	
	if [ -d ${sublist3r_dir} ];then
		echo ""
	else
		cd ${S_dir}
		git clone https://github.com/aboul3la/Sublist3r
	fi

	cd ${sublist3r_dir}
	read -p "请输入主域名: " domain
	if [ -e ${E_dir}${domain} ];then
	    rm -rf ${E_dir}${domain}	
	fi	
        #mkdir ${E_dir}${domain}	
	/usr/bin/python2 sublist3r.py -d $domain  > ${E_dir}${domain}
	#mv ${sublist3r_dir}${domain}.txt ${E_dir}${domain}
	echo "结果：${E_dir}${domain}"
}

################# teemo #####################################

function teemo(){
	teemo_dir="${S_dir}teemo/"

	if [ -d ${teemo_dir} ]; then
	    echo ""
	else
	    cd ${S_dir}
	    git clone https://github.com/bit4woo/teemo.git
	fi

	cd ${teemo_dir}
	read -p "请输入主域名: " domain
	if [ -e ${E_dir}${domain} ];then
		rm -rf ${E_dir}${domain}
	fi
	python2 teemo.py -d $domain -o ${E_dir}${domain}
	#python2 teemo.py -d $domain > ${E_dir}${domain}
	echo "结果：${E_dir}${domain}"

}


################# ksubdomain #####################################

function ksubdomain(){
	ksubdomain_dir="${S_dir}ksubdomain/"
	if [ -d ${ksubdomain_dir} ]; then
		echo ""
	else
		cd ${S_dir}
		git clone https://github.com/knownsec/ksubdomain
	fi
	cd ${ksubdomain_dir}
	read -p "请输入主域名: " domain
	if [ -e ${E_dir}${domain} ];then
		rm -rf ${E_dir}${domain}
	fi
	ksubdomain -d ${domain}
	echo "结果：${E_dir}${domain}"
}






################# case #####################
case ${imp} in 
	"sub")
	    subdomainsBrute
	;;
	"sublist3r")
	    sublist3
	;;
	"teemo")
	    teemo
	;;
	"ks")
		ksubdomain
	;;
	q|quit|Q)
	    exit 0
	;;
	*)
	echo  "  Are you Ok ! "
esac
