#!/bin/bash
_IFS=$IFS
IFS=$'\n'
pjstat="  ACCEPT QUEUED  STGIN  READY RUNING RUNOUT STGOUT   HOLD  ERROR   TOTAL
       0      0      0      0      2      0      0      0      0       2
s      0      0      0      0      2      0      0      0      0       2

JOB_ID     JOB_NAME   MD ST  USER     START_DATE      ELAPSE_LIM NODE_REQUIRE    VNODE  CORE V_MEM
24302383   ito.sh     NM RUN p70486a  12/25 18:17:58< 0096:00:00 -               1      36   unlimited
24303924   ito.sh     NM RUN p70486a  12/25 19:47:21< 0096:00:00 -               1      36   unlimited
24303924   ito.sh     NM RUN p70486a  12/25 19:47:21< 0096:00:00 -               1      36   unlimited
24303924   ito.sh     NM RUN p70486a  12/25 19:47:21< 0096:00:00 -               1      36   unlimited"
# コマンドで得られた結果の行数を指定して取得. ここでは，６行目以降を取得
temp="$(echo "$pjstat" | sed -n '6,$p')"
# 上のコマンドのみでは，要素1つの文字列として認識されているため，改行で分割して配列に渡してやる
IFS=$' '
jobs=()
# 複数行ある出力を一文ずつ処理するのに有効
echo "$temp" | while read -r line; do
    read -ra words <<< "${line}"
    # 0埋めする
    # echo "[$(printf "%02d\n" "${i}")]: ${words[0]}"
    # インクリメント
    jobs+=("${words[0]}")
done

i=0
for job in "${jobs[@]+"${jobs[@]}"}"; do
    echo "[$(printf "%02d\n" "${i}")]: ${jobs[0]}"
    i=$(( i + 1 ))
done

IFS=$_IFS
