# riscv-f2c-FP simples.asm
# Converte graus celsius em farenheit, usando nros de ponto flutuante
#
# Versão simplificada, SEM USO DE PILHA / STACK POINTER 
#  1- Lê graus F armazenado na memória
#  2- Cálcula graus C usando a fórmula C= (F -32) * 5 / 9
#  3- imprime msg com resulto
#

.data
fp_grausF: .float  85.0
fp_grausC: .float  0.0
fp_cte5: .float 5.0
fp_cte9: .float 9.0
fp_cte32: .float 32.0
str1:     .string "Graus Farenheit =  "
str2:     .string "Graus Celsius =  "
pulaLinha: .string "\n"

# ft0 = 5 (flw da memoria)
# ft5 = reg auxiliar para as opera��es matem�ticas
# ft1 = grau em celsius
#
#
#
#


.text
main:

        flw  ft0, fp_grausF, t5   # ft0= F | lw normal, como uso uma label, preciso passar um reg auxiliar(t5)
        
       
        flw  ft5, fp_cte32, t5   # ft5= 32
        fsub.s ft1, ft0, ft5  # ft1= F-32

        flw  ft5, fp_cte5, t5   # ft5= 5
        fmul.s ft1, ft1, ft5  # ft1= (F-32) * 5
       

        flw  ft5, fp_cte9, t5   # ft5= 9
        fdiv.s ft1, ft1, ft5  # ft1= (F-32) * 5 / 9
        
        la t3, fp_grausC # guardo o endere�o de grausC
        fsw ft1, 0(t3)   # coloco o valor em celsius na mem�ria( grausC)
        
        
        # Imprimir resultados no console  (argumentos em a0 e a1)
         flw  fa0, fp_grausF, t5   # fa0= F
         flw  fa1, fp_grausC, t5   # fa1= C
         jal ra, printResultado # pula para printresultado guarda endere�o em ra

        # Exit program
        li a7, 10
        ecall


# --- printResultado ---
# fa0: Graus F
# fa1: Graus C

printResultado:
        fmv.s ft0, fa0 # copio F e C para regs t
        fmv.s ft1, fa1
       
        
        la a0, str1
        li a7, 4
        ecall
        
        fmv.s fa0, ft0 # passo F para fa0
        li a7, 2  # a7 = 2 --> ecall imprime floating point
        ecall
        
        la a0, pulaLinha
        li a7, 4
        ecall
        
        la a0, str2
        li a7, 4
        ecall
        
        fmv.s fa0, ft1
        li a7, 2
        ecall
              
        ret
        
