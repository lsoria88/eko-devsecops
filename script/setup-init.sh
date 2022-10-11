#!/bin/bash

# Autor: lsoria88 - Setup in project for each new environment.

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT
function ctrl_c() {
    echo -e "\n${redColour}[*] Saliendo...${endColour}\n"
}

function helpPanel(){
    echo -e "\n${yellowCOlour}[*]${endColour}${grayColour} Uso ./setup-init.sh${endColour}"
    echo -e "\t${purpleColor}b) ${endColour}${yellowColour} Nombre del bucket S3 ${endColour}"
    echo -e "\t${purpleColor}a) ${endColour}${yellowColour} Numero de cuenta AWS ${endColour}"
    exit 0
}

function setupInit(){
    echo "Creando el bucket {bucket_name=$name_bucket}"
    EXE_CREATE_S3=$(aws s3api create-bucket --bucket $name_bucket --region us-east-1 2> /dev/null);
    ret=$?
    if [ $ret -eq 0 ];then
        echo -e "${turquoiseColour}[*] Bucket creado exitosamente${endColour}\n"
    else
        echo -e "${redColour}[*] Error al crear bucket${endColour}\n"
        return $ret
    fi
}

function createPolicy(){
    echo "Creando user iam en cuenta ${account_aws}"
    OLD_ACCOUNT_AWS=$(cat trust-policy.json | grep AWS | awk '{print $6}' FS=:)
    sed -i "s/iam::.*/iam::${account_aws}:root\"/g" trust-policy.json
    EXEC_IAM_USER=$(aws iam create-role --role-name Role_devsecops --assume-role-policy-document file://trust-policy.json 2> /dev/null)
    ret=$?
    if [ $ret -eq 0 ] || [ $ret -eq 254 ];then
        
        if [ $ret -eq 254 ]; then
            echo -e "${turquoiseColour}[*] Rol ya existente${endColour}\n"
            else
                echo -e "${turquoiseColour}[*] Rol creado exitosamente${endColour}\n"
            fi
    else
        echo -e "${redColour}[*] Error al crear el Rol${endColour}\n"
        return $ret
    fi 
    EXEC_IAM_POLICY=$(aws iam put-role-policy --role-name Role_devsecops --policy-name administrator-full-access --policy-document file://administrator-full.json)
    ret=$?
    if [ $ret -eq 0 ];then
        echo -e "${turquoiseColour}[*] Politica adjuntada exitosamente${endColour}\n"
    else
        echo -e "${redColour}[*] Error al adjunta la politica${endColour}\n"
        return $ret
    fi 

}

function modifyParameters(){
    cd ..
    cd terraform
    sed -i "s/$OLD_ACCOUNT_AWS/${account_aws}/g" *
    #TODO: replace other parameter 
}

#Main Function

if [ "$(id -u)" != "0" ]; then
    declare -i parameter_count=0; while getopts ":b:a:h:" arg; do
        case $arg in
            b) name_bucket=$OPTARG; let parameter_count+=1 ;;
            a) account_aws=$OPTARG; let parameter_count+=1 ;;
            h) helpPanel ;;
        esac
    done
    if [ $parameter_count -ne 2 ]; then
        helpPanel
    else
        setupInit
        createPolicy
        modifyParameters #TODO
    fi
else
    echo "\n${redColour}[*] Ejecutar con usuario root no es necesario${redColour}\n"

fi
