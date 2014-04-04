#!/bin/bash

red="\e[31m"
green="\e[32m"
blue="\e[34m"
white="\e[97m"
rcolor="\e[0m"

dotdir=~/
dir=~/dotfiles
backup=$dir"/backup"
me=$dir"/"`basename $0`

makeSymlink(){
  echo -e $green"Symlinking overwriting "$1" -> "$2$rcolor
  rm $2
  ln -s $1 $2

}

recursive() {
  for i in "$1"/*;do
     if [ -d "$i" ];then
        recursive "$i"
     elif [ -f "$i" -a "$i" != "$me" ]; then
	   dotfile=$dotdir'.'$(basename $i)
	   if [ -f $dotfile ]; then
		echo -e $white"File "$dotfile" already exists"$rcolor
		echo -e "\t"$red"Do you wish to ovewrite the config file?"$rcolor
		select yn in "Yes" "No"; do
    			case $yn in
        			Yes) makeSymlink $i $dotfile; break;;
        			No) break;;
    			esac
		done
	   else
	   	echo -e $green"Symlinking "$i" -> "$dotfile$rcolor
		ln -s $i $dotfile
	   fi
     fi
  done
}

recursive $dir
