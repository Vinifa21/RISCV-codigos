.data # �rea de dados
msg: .string "Ola ARQ1 DC-UFSCAR!! \n" # Copy the string "Hello World!\n" into memory 

.text # �rea de código
main: # 

  li a0, 1  # li means to Load Immediate and we want to load the value 1 into register a0
  la a1, msg # la is similar to li, but works for loading addresses
  li a2, 22  # like the first line, but with 13. This is the final argument to the system call
  
  lw t0, 78
  li a7, 64  # a7 is what determines which system call we are calling and we what to call write (64)
  ecall      # actually issue the call

  li a0, 0   # The exit code we will be returning is 0
  li a7, 93  # Again we need to indicate what system call we are making and this time we are calling exit(93)
  ecall 
