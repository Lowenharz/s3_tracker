#!/bin/bash
PROFILE="default"
while getopts "h?o:p:" OPTION
do 
    case $OPTION in 
        h) 
            echo "s3_runtracker.sh -o <output_csv> -p <S3_profile_name>"
            exit
            ;;
        o) 
            OUTPUT=$OPTARG
            ;;
        p)  
            PROFILE=$OPTARG
            ;;
        : )
            echo "Missing option argument for -$OPTARG"
            exit
            ;;
    esac
done
# echo $PROFILE
aws s3 --cli-read-timeout 300 --endpoint-url https://ussd.s3.illumina.com ls s3://K2_backup --profile $PROFILE | sed 's/                           PRE//g'|cat > $OUTPUT
