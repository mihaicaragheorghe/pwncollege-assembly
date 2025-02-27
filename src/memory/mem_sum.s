.intel_syntax noprefix
.global _start
_start:
mov rax, [rdi]      # Load first qword from memory at rdi
mov rbx, [rdi+8]    # Load second qword from memory at rdi+8
add rax, rbx        # Sum the 2 values
mov [rsi], rax      # Store sum at rsi

# [0x1337] = 0x00000000deadbeef
# The real way memory is laid out is byte by byte, little endian:
# 
# [0x1337] = 0xef
# [0x1337 + 1] = 0xbe
# [0x1337 + 2] = 0xad
# ...
# [0x1337 + 7] = 0x00
