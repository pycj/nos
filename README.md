# nos
***A simple os-kernel based on x86***

## note
* Make sure you have these tools: gcc make qemu-system-i386 bochs
* on ubuntu
```
sudo apt install qemu-system-x86 bochs
```
* Make sure these enviroment variables in your PATH: bochs bximage qemu-system-i386

## run
```sh
git clone https://github.com/pycj/nos.git
cd nos/src
make qemu
```  

## TODO
* FileSystem
* Network
