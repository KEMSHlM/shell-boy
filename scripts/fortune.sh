#!/bin/zsh

if [ $# -ne 1 ]; then
  echo "Please input your name."
  exit 1
fi

echo $1