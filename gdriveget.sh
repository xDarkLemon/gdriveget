#!/bin/bash
mkdir gdriveget
SLNK=$1
FNAME=$2
FILEID=${SLNK/"https://drive.google.com/file/d/"/""}
FILEID=${FILEID/"/view?usp=sharing"/""}
wget --quiet --save-cookies gdriveget/cookies.txt --keep-session-cookies --no-check-certificate "https://drive.google.com/uc?export=download&id=${FILEID}" -O $FNAME
HEAD=$(cat $FNAME | head -n 1)
TAIL=$(cat $FNAME | tail -n 1)
if [[ $(echo $HEAD | grep "Google Drive - Virus scan warning") != "" ]] && [[ $(echo $TAIL | grep $FILEID) != "" ]]
then
    COOKIEFILE=$(cat gdriveget/cookies.txt)
    CODE=${COOKIEFILE:0-4:4}
    wget --load-cookies gdriveget/cookies.txt "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILEID}" -O $FNAME
fi
rm -rf gdriveget
