default rel

section .rodata
msg: db "Hello, World!", 0

section .text
global hello
hello:
    mov rax, 1
    mov rdi, 1
    lea rsi, [msg]
    mov rdx, 14
    push rcx
    syscall

    pop rcx
    mov rax, 60
    xor rdi, rdi
    syscall

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
