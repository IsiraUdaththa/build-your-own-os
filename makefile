
# sudo apt-get install g++ binutils libc6-dev-i386 
# sudo apt-get install VirtualBox xorriso mtools grub-pc-bin

GCCPARAMS = -m32 -Isrc -fno-use-cxa-atexit -nostdlib -ffreestanding -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -Wall -Wextra
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = build/arch/x86/loader.o build/arch/x86/gdt.o build/arch/x86/port.o build/core/kernel.o

# Compiles C++ files
build/%.o: src/%.cpp
	@mkdir -p $(@D)
	g++ $(GCCPARAMS) -c -o $@ $<

# Compiles Assembly files
build/%.o: src/%.S
	@mkdir -p $(@D)
	as $(ASPARAMS) -c -o $@ $<

# Links the kernel binary
build/mykernel.bin: src/linker.ld $(objects)
	@mkdir -p $(@D)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

# Copy the kernel binary to /boot
install: build/mykernel.bin
	sudo cp $< /boot/mykernel.bin

# Create the ISO image
build/mykernel.iso: build/mykernel.bin
	mkdir -p build/iso/boot/grub
	cp $< build/iso/boot/mykernel.bin
	echo 'set timeout=0'                      > build/iso/boot/grub/grub.cfg
	echo 'set default=0'                     >> build/iso/boot/grub/grub.cfg
	echo ''                                  >> build/iso/boot/grub/grub.cfg
	echo 'menuentry "Build Your Own OS" {'	 >> build/iso/boot/grub/grub.cfg
	echo '  multiboot /boot/mykernel.bin'    >> build/iso/boot/grub/grub.cfg
	echo '  boot'                            >> build/iso/boot/grub/grub.cfg
	echo '}'                                 >> build/iso/boot/grub/grub.cfg
	grub-mkrescue --output=$@ build/iso
	rm -rf build/iso

run: build/mykernel.iso
	(killall VBoxManage && sleep 1) || true
	VBoxManage startvm 'Build Your Own OS' &

clean:
	rm -rf build
