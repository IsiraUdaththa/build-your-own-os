
# sudo apt-get install g++ binutils libc6-dev-i386

GCCPARAMS = -m32 -Isrc -fno-use-cxa-atexit -nostdlib -ffreestanding -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -Wall -Wextra
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = build/arch/x86/loader.o build/core/kernel.o

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

clean:
	rm -rf build
