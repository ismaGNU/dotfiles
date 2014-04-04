#!/bin/bash

dir=~/dotfiles

recursive() {
  for i in "$1"/*;do
     if [ -d "$i" ];then
        recursive "$i"
     elif [ -f "$i" ]; then
        echo "Processing: $i"
	#ln -s $dir/$i ~/.$i
     fi
  done
}

recursive $dir
