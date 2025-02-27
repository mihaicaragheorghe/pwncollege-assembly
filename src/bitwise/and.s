.intel_syntax noprefix
.global _start
_start:
and rdi, rsi    # Perform AND on rdi and rsi, result would be calculated by ANDing each bit pair one by one
xor rax, rax    # This effectively clears rax by XORing itself
or rax, rdi     # We use OR to set rax to rdi without using mov

# rax = rdi AND rsi using only bitwise operators
