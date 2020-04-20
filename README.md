## Testes para Compiladores - Parte 2

---

**Lê isto com atenção:**

O diretório `/src` contém o código da base do projeto
como dado pelo professor (o pburg está incompleto).

O diretório `/test` tem todos os testes da primeira entrega, dados pelo professor, mais os testes para a segunda entrega.

## Correr os testes

```sh
cd test
chmod +x p2.sh # Este comando só precisa de ser feito 1 vez
./p2.sh
make clean # Isto limpa os resultados anteriores
```

Cada teste possui a sua pastinha com vários ficheiros:
* `test.min` - contém o código do programa a ser testado

Depois, cada teste é formado por vários ficheiros com o mesmo nome (extensão diferente):

* `tXX.in` - input dado 
* `tXX.out` - output esperado
* `tXX.ret` - exit code esperado (return da main)

Ao correr os testes, as pastas vão ter mais uns ficheiros:
* `tXX.myout` - output obtido
* `tXX.diff` - diferenças entre o `tXX.myout` e `tXX.out` (literalmente um diff)
* `tXX.myret` - exit code obtido

Os testes passam se os outputs e exit codes obtidos são iguais aos esperados. Ou seja, se `tXX.out == tXX.myout` e `tXX.ret == tXX.myret`.

## Como contribuir

Para contribuir, podes:

1. Fazer um fork do projeto, fazer as tuas alterações e depois um pull request.
2. Pedir-me para ter acesso de escrita (através do slack (Afonso Matos)), e assim podes criar o teu branch e fazer pull request.