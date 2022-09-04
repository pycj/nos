BUILD=../build
SRC=.

DEBUG=-g
DWARF=DWARF

ENTRYPOINT:=0x10000

CFLAGS=-m32
CFLAGS+=-fno-builtin
CFLAGS+=-nostdinc
CFLAGS+=-fno-pic
CFLAGS+=-fno-pie
CFLAGS+=-nostdlib
CFLAGS+=-fno-stack-protector

DEBUG= -g
NASMDEBUG= -gdwarf
INCLUDE=-I$(SRC)/include

$(BUILD)/boot/%.bin: ./boot/%.asm
	$(shell mkdir -p $(dir $@))
	nasm -f bin -o $@ $<

$(BUILD)/kernel/%.o: ./kernel/%.asm
	$(shell mkdir -p $(dir $@))
	nasm -f elf32 $(NASMDEBUG) -o $@ $<

$(BUILD)/lib/%.o: ./lib/%.c
	$(shell mkdir -p $(dir $@))
	gcc $(CFLAGS) $(DEBUG) $(INCLUDE) -c -o $@ $<

$(BUILD)/kernel/%.o: ./kernel/%.c
	gcc $(CFLAGS) $(DEBUG) $(INCLUDE) -c -o $@ $<

$(BUILD)/kernel.bin: ../build/kernel/start.o \
					 ../build/kernel/main.o \
					 ../build/kernel/io.o \
					 ../build/kernel/console.o \
					 ../build/kernel/printk.o \
					 ../build/kernel/assert.o \
					 ../build/kernel/debug.o \
					 ../build/kernel/global.o \
					 ../build/kernel/task.o \
					 ../build/kernel/schedule.o \
					 ../build/kernel/handler.o \
					 ../build/kernel/interrupt.o \
					 ../build/lib/string.o \
					 ../build/lib/vsprintf.o \
					 ../build/lib/stdlib.o 
	ld -melf_i386 -static -Ttext $(ENTRYPOINT) -o $@ $^

$(BUILD)/system.bin: ../build/kernel.bin
	objcopy -O binary $< $@

$(BUILD)/system.map: ../build/kernel.bin
	nm $< | sort > $@

$(BUILD)/master.img: ../build/boot/boot.bin \
					 ../build/boot/loader.bin \
					 ../build/system.bin
	yes | bximage -mode=create -hd=16 -sectsize=512 -q $@
	dd if=../build/boot/boot.bin of=$@ count=1 bs=512 conv=notrunc
	dd if=../build/boot/loader.bin of=$@ count=4 bs=512 conv=notrunc seek=1
	dd if=../build/system.bin of=$@ count=200 bs=512 conv=notrunc seek=5

.PHONY: test
test:$(BUILD)/master.img $(BUILD)/system.map

.PHONY: bochsgdb
bochsgdb: ../build/master.img
	bochsgdb -q -f bochsgdbrc

.PHONY: bochs
bochs: ../build/master.img
	bochs -q

.PHONE: qemu
qemu: $(BUILD)/master.img
	qemu-system-i386 \
	-m 32M \
	-boot c \
	-hda $< \

.PHONE: qemug
qemug: $(BUILD)/master.img
	qemu-system-i386 \
	-s -S \
	-m 32M \
	-boot c \
	-hda $< 

.PHONY: clean
clean:
	rm -rf ../build
