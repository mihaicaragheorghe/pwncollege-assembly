.intel_syntax noprefix
.global _start
_start:
mov rax, [0x404000]
add qword ptr [0x404000], 0x1337

# This will move the value stored at 0x404000 into rax then increment the value stored at 0x404000 by 0x1337
