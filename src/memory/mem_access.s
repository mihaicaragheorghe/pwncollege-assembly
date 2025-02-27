.intel_syntax noprefix
.global _start
_start:
mov rax, 0
mov al, [0x404000]
mov rbx, 0
mov bx, [0x404000]
mov rcx, 0
mov ecx, [0x404000]
mov rdx, 0
mov rdx, [0x404000]

# The breakdown of the names of memory sizes:
# Quad Word = 8 Bytes = 64 bits
# Double Word = 4 bytes = 32 bits
# Word = 2 bytes = 16 bits
# Byte = 1 byte = 8 bits
#
# In x86_64, you can access each of these sizes when dereferencing an address, just like using bigger or smaller register accesses:
# mov al, [address] <=> moves the least significant byte from address to rax
# mov ax, [address] <=> moves the least significant word from address to rax
# mov eax, [address] <=> moves the least significant double word from address to rax
# mov rax, [address] <=> moves the full quad word from address to rax
