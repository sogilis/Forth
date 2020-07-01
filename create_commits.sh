#! /bin/bash

CHANGE_FILE=commit_number

for I in in $(seq 1 100)
do
	echo $I > $CHANGE_FILE
	git add $CHANGE_FILE
	git commit -m "Suspicious commit $I"
done
