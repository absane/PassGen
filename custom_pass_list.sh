#!/bin/bash

rm /tmp/temp_passwords
rm /tmp/temp_passwords2
rm /tmp/temp_passwords3
rm /tmp/pass

echo "Please enter company name (seperate variations with a space): "
read company_name

echo "Please enter username name (seperate variations with a space): "
read user_name

echo "Please enter any other keywords (seperate variations with a space): "
read keywords

commonwords="Spring Summer Fall Winter changeme password welcome Passw0rd P@ssW0rd P@ssword"
commonwords=$commonwords' qwerty'

feed_list=$company_name' '$user_name' '$keywords' '$commonwords

IFS=' ' read -ra var <<<"$feed_list"
for v in "${var[@]}"
do
	to_lower=$v; echo "${to_lower,}" >> /tmp/temp_passwords
	to_upper=$v; echo "${to_upper^}" >> /tmp/temp_passwords
done

cp /tmp/temp_passwords /tmp/temp_passwords2

if [ ! -z "$1" ] ; then
	user_supplied_list=$company_name' '$user_name' '$keywords' password'
	IFS=' ' read -ra var <<<"$user_supplied_list"
	for i in "${var[@]}"
		do
			python passgen.py -f $i | grep -v "passwords generated"  >> /tmp/temp_passwords
	done
fi

years=""
for i in {-1..5}
do
	years=$years$(date  --date="$i year ago" +"%Y")" "
	years=$years$(date  --date="$i year ago" +"%y")" "
done

#IFS=' ' read -ra var <<<"$feed_list"
#for v in "${var[@]}"
for i in $(cat /tmp/temp_passwords)
do
	echo $i"!" >> /tmp/temp_passwords
	IFS=' ' read -ra var <<<"${years::-1}"
	for v in "${var[@]}"
	do
		echo $i'!'$v >> /tmp/temp_passwords
		echo $i$v >> /tmp/temp_passwords
		echo $i$v"!" >> /tmp/temp_passwords
	done
done

#######################################

for v in $(cat /tmp/temp_passwords2)
do
	echo $v"10" >> /tmp/temp_passwords3
	echo $v"!" >> /tmp/temp_passwords3
	echo $v"123" >> /tmp/temp_passwords3
	echo $v"1234" >> /tmp/temp_passwords3
done

cat /tmp/temp_passwords /tmp/temp_passwords2 /tmp/temp_passwords3 | sort -u > /tmp/temp_passwords4


user_supplied_list=$company_name' '$user_name' '$keywords
IFS=' ' read -ra var <<<"$user_supplied_list"
if [ ! -z "$1" ] ; then
	for i in "${var[@]}"
		do
			python passgen.py -f $i | grep -v "passwords generated"  >> /tmp/temp_passwords4
	done
else
		for i in "${var[@]}"
		do
			python passgen.py $i | grep -v "passwords generated"  >> /tmp/temp_passwords4
	done
fi

cat /tmp/temp_passwords4 | egrep -v '(.*)([0-9]{5})' | sort -u > pass.txt
