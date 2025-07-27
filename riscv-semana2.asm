# riscv-semana2.asm
# Trechos de cÃ³digo da aula teÃ³rica da semana 2
# Objetivos: 
#    -Entender o funcionamento do computador simplificado
#    -Contato inicial com programaÃ§Ã£o assembly RISC-V
#	- ver registradores (não o terminal) para verificar operações

# tudo que está aqui vai ser armaenado na memória
.data
e: .string "\n Entrei no else"
x: .word 5,6,7 #ex: posso acessar x, dando la s0, x (carrego seu endereço) || uso lw, para acessar seu valor
y: .string " \n ufscar"
z: .string "computacao"
k: .word 55

memDados: .word  7,1,25,3,4,5,6,7,8,9
abc: .word 55
pulaLinha: .string "\n\r"


.text # indica que começa o código em si


main:

       ######## PARTE A: - InstruÃ§Ãµes adiÃ§Ã£o / subtraÃ§Ã£o:
       #InicializaÃ§Ã£o de registradores
       #addi soma reg com constante
       addi t1, zero, 0 # t1 = 0
       addi t2, zero, 5 
       addi t3, zero, 36 # t3 = 36
       addi t4, zero, 4
       
      
       add t1, t2, t3
       
       sub t1, t2, t3
       
       
       add t1, t2, t3  
       sub t1, t1, t4
       
       li a7, 1 # código para printar inteiro
       mv a0,t1 # a0 é de onde o so puxa o que será pirintado
       ecall # chamada para so
       
       li a7,4
       la a0, pulaLinha # carrego endereço de pulaLinha em a0
       ecall
       
       li a7, 1
       mv a0,t1 
       ecall
       
       
       
       
       ######## PARTE B: - InstruÃ§Ãµes multiplicaÃ§Ã£o / divisÃ£o
       #InicializaÃ§Ã£o de registradores
       addi s1, zero, 100
       addi s2, zero, 60 
       addi s3, zero, 20
       addi s4, zero, 15
       
       
       
       #InstruÃ§Ãµes multiplicaÃ§Ã£o / divisÃ£o
       
       mul s3, s1, s2 # pega os 32 bits menos significativos
       mulh s4, s1, s2 
       
       div  s3, s1, s2  # s3 = s1/s2
       rem  s4, s1, s2  # s4 = s1%s2




	######## PARTE C: -InstruÃ§Ãµes LÃ³gicas (and, or, xor)
	#colocando os resultados em s2 (alternam entre 0 e 1)
	li s0, 0
	li s1, 1
	
	and s2, s0, s1 # and entre 0 e 1
	andi s2, s1, 1 # and entre 1 e 1
	
	ori s2, s0, 0
	or s2, s0, s1
	
	xori s2, s1, 1
	xor s2, s0, s1
	
	
	
	######## PARTE D: -InstruÃ§Ãµes de acesso Ã  memÃ³ria (lw, sw)
	 la t1, memDados  # la: instruÃ§Ã£o para armazenar em t1 o endereÃ§o de um dado na memÃ³ria de dados. 
	 #agora t1 armazena o adress do primeiro elemento do vetor
	 la t2, abc
	 lw s3, 8(t1) #8(t1) = ando dois valores pra dir no vetor, t1 é o ínicio do vetor- || s3 armazena o terceiro elemento do vetor
	#     ,memoria
	 sw s3, 0(t1) # salvo no lugar do primeiro elemento do vetor (na memória), o valor de s3
	 
	
	######## PARTE E: -ProgramaÃ§Ã£o: desvio condicional (if-then, if-then-else)
	
	# IF, THEN#####################################################################3
	li a7, 4 # código para ecall printar string
	bne s0, s1, Print_ufscar # se s0 e s1 são diferente, pula para a label print_ufscar
	#se bne --> beq, ele também iria imprimir computacao
	
	la a0, z # printa computacao
	ecall
	
	Print_ufscar:
		la a0, y #printa ufscar
		ecall
	#IF, THAN, ELSE
	
	beq s0, s1,L1 # executa o then se beq --> b
		#aqui é o else
		la, a0, e
		ecall
		j done #pula para done (pulo tudo da label L1)
		
	L1: #aqui é o then
		ecall #printo ufscar denovo
	
done: #continuidade do código
	
	
	######## PARTE F: -ProgramaÃ§Ã£o: loops (for, while)

	#WHILE
	
	li t0, 0 #valor que se altera
	li t1, 5 # valor alvo
	
	while:
		beq, t0, t1, done1 # se condição for atingida, pula para done
		addi t0, t0, 1
		j while # volta para while, e condicao é verificada no beq
		
done1: #volta para código normal
	
	#FOR:
	li t0, 0 #valor que se altera (i do for)
	li t1, 5 # valor alvo
	li t2, 0 #armazena a soma( 1 + 2 + 3 + + 5)
	
	for:
	beq t0, t1, done2
	addi t0, t0, 1
	add t2, t2, t0
	j for # volta para for (condição é checada no beq
	

done2:    


        # Exit program
        li a7, 10
        ecall


