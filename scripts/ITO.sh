#!/bin/bash
# 実行時にこのシェルがある場所で実行される．非推奨らしいが動くのでよし
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

    # $i というディレクトリがなければ生成．
    # if [ 処理 ]; then -> ifの前後はスペースがいる
    if [ ! -d "$i" ]; then
        mkdir "$i"
    fi
    start=$((290+i*iter))
    end=$((start+iter-1))
    # 0 ディレクトリのshell scriptをコピー
    cp ../bin/exe ./"$i"/ 
    cp ./0/multirun.sh ./"$i"/

    # ここでやっているのは，先ほどコピーしたshell scriptの一部を書き換えている．
    # 6行目の48を24に置換，13行目をファイル名に応じて置換． 
    # iオプションをつけないと保存されない
    sed -i.bak -e "6 s/48/24/gp" -e "13 s/290 1 309/${start} 1 ${end}/gp" ./"$i"/multirun.sh
    # 使用なのか，私の環境で起きる現象なのかわからないが，上のコマンドは置換ではなく，変更した行を下に複製してしまう．
    # そこで，複製前の行を削除している．
    sed -i.bak -e "7d" -e "14d" ./"$i"/multirun.sh
    rm "$i"/*.bak

    cd "$i" || exit
    # 変更した内容で別のshell scriptを実行．ここでコンパイルして実行するのもいいね
    pjsub multirun.sh
    cd ..
done
