.intel_syntax noprefix
.global _start
_start:
mov rax, [0x404000]

# This will place the value stored at 0x404000 into rax
# 
# In x86, we can access the thing at a memory location, called dereferencing, like so:
# mov rax, [some_address]        <=>     Moves the thing at 'some_address' into rax
#
# This also works with things in registers: 
# mov rax, [rdi]         <=>     Moves the thing stored at the address of what rdi holds to rax
#
# This works the same for writing to memory:
# mov [rax], rdi         <=>     Moves rdi to the address of what rax holds.
# So if rax was 0xdeadbeef, then rdi would get stored at the address 0xdeadbeef: [0xdeadbeef] = rdi
