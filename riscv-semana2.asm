# riscv-semana2.asm
# Trechos de código da aula teórica da semana 2
# Objetivos: 
#    -Entender o funcionamento do computador simplificado
#    -Contato inicial com programação assembly RISC-V
#	- ver registradores (n�o o terminal) para verificar opera��es

# tudo que est� aqui vai ser armaenado na mem�ria
.data
e: .string "\n Entrei no else"
x: .word 5,6,7 #ex: posso acessar x, dando la s0, x (carrego seu endere�o) || uso lw, para acessar seu valor
y: .string " \n ufscar"
z: .string "computacao"
k: .word 55

memDados: .word  7,1,25,3,4,5,6,7,8,9
abc: .word 55
pulaLinha: .string "\n\r"


.text # indica que come�a o c�digo em si


main:

       ######## PARTE A: - Instruções adição / subtração:
       #Inicialização de registradores
       #addi soma reg com constante
       addi t1, zero, 0 # t1 = 0
       addi t2, zero, 5 
       addi t3, zero, 36 # t3 = 36
       addi t4, zero, 4
       
      
       add t1, t2, t3
       
       sub t1, t2, t3
       
       
       add t1, t2, t3  
       sub t1, t1, t4
       
       li a7, 1 # c�digo para printar inteiro
       mv a0,t1 # a0 � de onde o so puxa o que ser� pirintado
       ecall # chamada para so
       
       li a7,4
       la a0, pulaLinha # carrego endere�o de pulaLinha em a0
       ecall
       
       li a7, 1
       mv a0,t1 
       ecall
       
       
       
       
       ######## PARTE B: - Instruções multiplicação / divisão
       #Inicialização de registradores
       addi s1, zero, 100
       addi s2, zero, 60 
       addi s3, zero, 20
       addi s4, zero, 15
       
       
       
       #Instruções multiplicação / divisão
       
       mul s3, s1, s2 # pega os 32 bits menos significativos
       mulh s4, s1, s2 
       
       div  s3, s1, s2  # s3 = s1/s2
       rem  s4, s1, s2  # s4 = s1%s2




	######## PARTE C: -Instruções Lógicas (and, or, xor)
	#colocando os resultados em s2 (alternam entre 0 e 1)
	li s0, 0
	li s1, 1
	
	and s2, s0, s1 # and entre 0 e 1
	andi s2, s1, 1 # and entre 1 e 1
	
	ori s2, s0, 0
	or s2, s0, s1
	
	xori s2, s1, 1
	xor s2, s0, s1
	
	
	
	######## PARTE D: -Instruções de acesso à memória (lw, sw)
	 la t1, memDados  # la: instrução para armazenar em t1 o endereço de um dado na memória de dados. 
	 #agora t1 armazena o adress do primeiro elemento do vetor
	 la t2, abc
	 lw s3, 8(t1) #8(t1) = ando dois valores pra dir no vetor, t1 � o �nicio do vetor- || s3 armazena o terceiro elemento do vetor
	#     ,memoria
	 sw s3, 0(t1) # salvo no lugar do primeiro elemento do vetor (na mem�ria), o valor de s3
	 
	
	######## PARTE E: -Programação: desvio condicional (if-then, if-then-else)
	
	# IF, THEN#####################################################################3
	li a7, 4 # c�digo para ecall printar string
	bne s0, s1, Print_ufscar # se s0 e s1 s�o diferente, pula para a label print_ufscar
	#se bne --> beq, ele tamb�m iria imprimir computacao
	
	la a0, z # printa computacao
	ecall
	
	Print_ufscar:
		la a0, y #printa ufscar
		ecall
	#IF, THAN, ELSE
	
	beq s0, s1,L1 # executa o then se beq --> b
		#aqui � o else
		la, a0, e
		ecall
		j done #pula para done (pulo tudo da label L1)
		
	L1: #aqui � o then
		ecall #printo ufscar denovo
	
done: #continuidade do c�digo
	
	
	######## PARTE F: -Programação: loops (for, while)

	#WHILE
	
	li t0, 0 #valor que se altera
	li t1, 5 # valor alvo
	
	while:
		beq, t0, t1, done1 # se condi��o for atingida, pula para done
		addi t0, t0, 1
		j while # volta para while, e condicao � verificada no beq
		
done1: #volta para c�digo normal
	
	#FOR:
	li t0, 0 #valor que se altera (i do for)
	li t1, 5 # valor alvo
	li t2, 0 #armazena a soma( 1 + 2 + 3 + + 5)
	
	for:
	beq t0, t1, done2
	addi t0, t0, 1
	add t2, t2, t0
	j for # volta para for (condi��o � checada no beq
	

done2:    


        # Exit program
        li a7, 10
        ecall


