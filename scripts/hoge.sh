#!/bin/bash
cd `dirname $0` || exit

# 割れる数字にしよう
N=50
iter=$((500/N))

# shell scriptでは，{}の中に変数を入れれない
for i in $(eval "echo {1..$((N-1))}")
do
    # お好みで
    rm ./"$i"/5atm.dat
    rm ./"$i"/multirun.sh.o*

    # if [ 処理 ]; then -> ifの前後はスペースがいる
    if [ ! -d "$i" ]; then
        mkdir "$i"
    fi
    start=$((290+i*iter))
    end=$((start+iter-1))
    cp ../bin/exe ./"$i"/ 
    cp ./0/multirun.sh ./"$i"/ 
    # iオプションをつけないと保存されない
    sed -i.bak -e "6 s/48/24/gp" -e "13 s/290 1 309/${start} 1 ${end}/gp" ./"$i"/multirun.sh
    sed -i.bak -e "7d" -e "14d" ./"$i"/multirun.sh
    rm "$i"/*.bak

    cd "$i" || exit
    pjsub multirun.sh
    cd ..
done
