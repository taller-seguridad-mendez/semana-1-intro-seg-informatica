ASM = nasm
ASMFLAGS = -f elf32
LD = ld
LDFLAGS = -m elf_i386

LABS = hello_world sys_exit gpr gpr_16_8 condition_codes privilege_level

.PHONY = all clean

all: $(LABS)

$(LABS): %: %.o
	$(LD) $(LDFLAGS) -o $@ $<

%.o: %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

deps:
	sudo apt update
	sudo apt install -y nasm gcc-multilib

clean:
	rm -f *.o $(LABS)
