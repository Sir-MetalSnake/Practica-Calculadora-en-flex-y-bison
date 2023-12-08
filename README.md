# Practica-Calculadora-en-flex-y-bison
Ruiz Ruiz Khrisna, Navarro Cossio Leonardo Alejandro, Grupo:4-02
flex calc.l
bison -d calc.y
gcc -o programa lex.yy.c calc.tab.c -lm -lfl
./programa
Listo :)
