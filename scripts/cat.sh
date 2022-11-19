#!/bin/bash
cd `dirname $0` || exit

filename="1atm.dat"
margefile="5atm.dat"
tempfile="temp.dat"
N=50

rm $filename
touch $filename
touch $tempfile

echo "start"

for i in $(eval "echo {0..$((N-1))}")
do
    cat $filename "$i"/$margefile > $tempfile
    cp $tempfile $filename
    rm $tempfile
done

echo "done"