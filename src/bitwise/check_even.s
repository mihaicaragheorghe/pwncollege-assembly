.intel_syntax noprefix
.global _start
_start:
and rdi, 1      # Check if rdi is even using AND (even numbers have LBS = 1)
xor rdi, 1      # Fip the result of check using XOR
xor rax, rax    # Clear rax
or rax, rdi     # Set rax = rdi using OR

# if x is even then
#   y = 1
# else
#   y = 0
#
# x = rdi
# y = rax
