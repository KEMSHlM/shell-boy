#!/bin/bash
# 実行時にこのシェルがある場所で実行される．非推奨らしいが動くのでよし
cd `dirname $0` || exit

# マージしてできる生成物
filename="1atm.dat"
# 各階層にあるマージされるファイル
margefile="5atm.dat"
# 一時保存用ファイル
tempfile="temp.dat"
# 階層の数，ここでは0-49の50個を想定している
N=50

rm $filename
touch $filename
touch $tempfile

echo "start"

for i in $(eval "echo {0..$((N-1))}")
do
    # ./$i/$magefile を$filenameに書き足す
    cat $filename "$i"/$margefile > $tempfile
    # tempfileに一時保存．
    cp $tempfile $filename
    # tempfileを削除．
    rm $tempfile
done

echo "done"