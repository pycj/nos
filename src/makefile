BUILD:=../build
SRC:=.

DEBUG=-g
DWARF=DWARF

ENTRYPOINT:=0x10000

CFLAGS:=-m32
CFLAGS+=-fno-builtin
CFLAGS+=-nostdinc
CFLAGS+=-fno-pic
CFLAGS+=-fno-pie
CFLAGS+=-nostdlib
CFLAGS+=-fno-stack-protector
CFLAGS:=$(strip ${CFLAGS})

DEBUG:= -g
NASMDEBUG:= -gdwarf
INCLUDE:=-I$(SRC)/include

../build/boot/%.bin: ./boot/%.asm
	$(shell mkdir -p $(dir $@))
	nasm -f bin -o $@ $<

../build/kernel/%.o: ./kernel/%.asm
	$(shell mkdir -p $(dir $@))
	nasm -f elf32 -g -F dwarf -o $@ $<

../build/lib/%.o: ./lib/%.c
	$(shell mkdir -p $(dir $@))
	gcc $(CFLAGS) $(DEBUG) $(INCLUDE) -c -o $@ $<

../build/kernel/%.o: ./kernel/%.c
	gcc $(CFLAGS) $(DEBUG) $(INCLUDE) -c -o $@ $<

../build/kernel.bin: ../build/kernel/start.o \
					 ../build/kernel/main.o \
					 ../build/kernel/io.o \
					 ../build/lib/string.o \
					 ../build/kernel/console.o
	ld -melf_i386 -static -Ttext $(ENTRYPOINT) -o $@ $^

../build/system.bin: ../build/kernel.bin
	objcopy -O binary $< $@

../build/system.map: ../build/kernel.bin
	nm $< | sort > $@

../build/master.img: ../build/boot/boot.bin \
					 ../build/boot/loader.bin \
					 ../build/system.bin
	yes | bximage -mode=create -hd=16 -sectsize=512 -q $@
	dd if=../build/boot/boot.bin of=$@ count=1 bs=512 conv=notrunc
	dd if=../build/boot/loader.bin of=$@ count=4 bs=512 conv=notrunc seek=1
	dd if=../build/system.bin of=$@ count=200 bs=512 conv=notrunc seek=5

.PHONY: test
test:../build/master.img ../build/system.map

.PHONY: bochsgdb
bochsgdb: ../build/master.img
	bochsgdb -q -f bochsgdbrc

.PHONY: bochs
bochs: ../build/master.img
	bochs -q

.PHONY: clean
clean:
	rm -rf ../build