.intel_syntax noprefix
.global _start
_start:
mov rax, 0x403000
jmp rax

# Absolute jumps: jump to a specific address.
# In x86, absolute jumps are accomplished by first putting the target address in a register reg, then doing jmp reg.
