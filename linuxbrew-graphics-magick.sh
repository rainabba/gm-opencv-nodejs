#!/bin/sh 
cd /home/linuxbrew 
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" 
export LD_LIBRARY_PATH="/home/linuxbrew/.linuxbrew/lib:$LD_LIBRARY_PATH" 
test -d ~/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH" 
echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile 
brew update && brew update  
brew install graphicsmagick 

