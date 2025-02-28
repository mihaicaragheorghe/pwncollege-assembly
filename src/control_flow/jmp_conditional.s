.intel_syntax noprefix
.global _start
_start:
    mov rax, 0
    cmp dword ptr [rdi], dword ptr 0x7f454c46
    je is_0x7f454c46
    cmp dword ptr [rdi], dword ptr 0x00005A4D
    je is_0x00005A4D
    jmp neither

is_0x7f454c46:
    mov eax, dword ptr [rdi+4]
    add eax, dword ptr [rdi+8]
    add eax, dword ptr [rdi+12]
    jmp done

is_0x00005A4D:
    mov eax, dword ptr [rdi+4]
    sub eax, dword ptr [rdi+8]
    sub eax, dword ptr [rdi+12]
    jmp done

neither:
    mov eax, dword ptr [rdi+4]
    imul eax, dword ptr [rdi+8]
    imul eax, dword ptr [rdi+12]

done:

# if [x] is 0x7f454c46:
#     y = [x+4] + [x+8] + [x+12]
# else if [x] is 0x00005A4D:
#     y = [x+4] - [x+8] - [x+12]
# else:
#     y = [x+4] * [x+8] * [x+12]
