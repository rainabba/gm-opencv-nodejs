#!/bin/bash 
cd /home/linuxbrew 
test -d ~/.linuxbrew
#/usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin
echo "export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin" >>~/.profile 
brew config && brew upgrade && brew update && brew install graphicsmagick
