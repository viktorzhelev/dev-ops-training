#!/bin/bash
cd /
myDir="/home/viktor/homework"
myFile="/home/viktor/homework/content.txt"
if [ -d "$myDir" ]; then 
	echo "${myDir}  already exists!"
else
	mkdir ${myDir}
fi
# mkdir -p ~/homework

if [ -f "$myFile" ]; then
	echo "${myFile} already exists!"
else
	touch ${myFile}
fi

now=$(date -u)
echo ${now} >> ${myFile}
cat ${myFile} | wc -l
output=$(tail -n1 ${myFile})
echo $output
