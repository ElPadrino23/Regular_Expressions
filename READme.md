# Evidencia 1: Implementación de Analisis Lexico
### Nombre: Luis Fernando Martinez Barragan | Matrícula: A01613426

## Descripción

El lenguaje que elegí es el lenguaje "Elfico", también conocido como Quenya, que segun (Omniglot, 2025) es una lengua construida creada por J. R. R. Derivada del ingles antiguo, el Finlandes y el latin. Talkien lo creo para los Elfos en su ficción de la Tierra Media. 

Las palabras a modelar son las siguientes: 

- Amil - palabra Quenya para 'Madre'
- An - 'Largo'
- Anarya - palabra para 'Dia del Sol', este hace referencia al segundo dia elfico.
- Anca - palabra que significa 'Mandibulas'
- And - 'Largo'

Segun FasterCapital (2025), El uso de un Automata Finito es la manera mas sencilla de reconocer patrones, y existen dos tipos: DFA y NFA. Un DFA (Automata Finito Determinista) solo puede ir a un estado y el NFA puede ir a varios estados con la misma entrada.

Para este proyecto decidi utilizar un DFA, ya que el objetivo es aceptar solo estas cinco palabras por lo que se puede seguir un solo camino para cada palabra y no se necesita un NFA. Ademas la ambiguedad de un NFA lo haria algo complicado de implementar. 

## Modelos

Solo genere un automata para este lenguaje, ya que este representa las cinco palabras. El automata solo es válido para el siguiente alfabeto:

**Σ = {A, m, i, l, n, a, r, y, c, d}**

Cualquier carácter que no esté en el alfabeto y que no aparezca explícitamente en el autómata no es aceptado.

![Automata Quenya](Quenya.png)

Otra forma de representar el automata es mediante una expresión regular. MongoDB (2025) menciona que ls expresiones regulares son patrones que se utilizan para hacer coincidir combinaciones de caracteres en cadenas. Entonces teniendolo en cuenta, el automata que diseñe se puede expresar de esta manera:

(^A)((mil)|(n(ε|arya|ca|d)))


## Implementación
 
Utilice el autómata para crear una base de datos en prolog, esta tiene el estado actual, el siguiente estado y la letra como derivado de la transicion, modelado de la siguiente forma:
 
```prolog
grafo(estado_actual, estado_siguiente, simbolo).
```
 
En los estados de aceptación, el automata tiene cinco estados de aceptacion:
 
```prolog
final(c).
final(g).
final(j).
final(k).
final(z).
```
 
El resto del código tiene una regla auxiliar que llama a la regla recursiva: 
 
```prolog
verificar([p,a,l,a,b,r,a]).
```
 
El caso base:
 
```prolog
validar([], Estado).
```
 
Y la regla recursiva:
 
```prolog
validar([p,a,l,a,b,r,a], Estado).
```
 
Todo esto se encuentra en el archivo `quenya.pl`, si la palabra se encuentra dentro de la base de datos, retornara True, en caso contrario retornara False
 
## Pruebas
 

 
**Pruebas exitosas**  Retornan True:
 
```
amil.
an.
anarya.
anca.
and.
```
 
**Pruebas fallidas** Retornar False:
Realmente cualquier palabra que no este dentro de la lista retornara 'False', algunos ejemplos que utilice  para la prueba fueron: 
 
```
amill.
hola.
anary.
ann.
anc.
```


## Análisis


## Análisis

**Complejidad temporal**

El programa utiliza recursion e itera sobre la base de datos verificando cada hecho una vez, esto es muy similar a un ciclo for. Ademas no hay ningun ciclo anidado, por lo que no importa cuantos datos haya en la base de datos, siempre se iterara una unica vez.


### verificar(Palabra)

Esta funcion llama a 'validar' y que este coincida por el grafo inicial, en este caso el grafo 'a'

- Mejor caso O(1): si la palabra es una lista vacía, esta llama a la funcion y de inmediato verifica si `a` es estado final, si no lo es, falla luego luego
- Caso promedio O(n): Por ejemplo, si la palabra es `[a, n, c, a]` (Anca). Delegara a la funcion validar y esta recorrera 4 letras antes de llegar a un estado de aceptacion
- Peor caso O(n): Por ejemplo si la palabra es `[a, n, a, r, y, a]` (Anarya). Delega a la funcion y esta recorre las 6 letras completas.la funcion solo inicializa el proceso pero su peor caso total depende de lo que haga la misma funcion

### validar([], Estado)

Como no se deben de procesar palabras, solo el estado de aceptacion 
- Mejor caso O(1): Si el estado final es 'c' llegara ahi después de leer 'a' y 'n' y el estado actual es `c`, que si es final, dandonos true de inmediato
- Caso promedio O(1):Mismo caso 
- Peor caso O(1): Mismo caso

### validar([Letra | Resto], Estado)

En este caso, se llama a la funcion,  la palabra se coloca entre corchetes y se coloca el estado inicial

- Mejor caso O(1): Si la primera letra no tiene ninguna transicion desde el estado actual, la funcion busca no encuentra y va a falla de inmediato, sin necesidad de entrar a la recursividad
- Caso promedio O(n): Si la palabra es invalida,  Se ejecutara el numero de la cantidad de lentras en la palabra, avanzara por los estados donde llegara al final y fallara.
- Peor caso O(n): Mismo caso que el caso promedio. 
## DFA vs NFA

Escogi el automata  DFA porque este me garantiza que cada estado y cada simbolo existe, ya que este es predecible y el automata no tendra que ir por varios caminos al mismo tiempo. Y un NFA me permite que desde un mismo estado y con el mismo simbolo se pueda mover a varios estados distintos. Como el lenguaje Quenya solo tiene cinco palabras y todas comparten el mismo prefijo, el DFA fue el mas sencillo.

Ademas que con un NFA, el peor caso seria  O(2^n) porque habraa que rastrear todos los posibles estados 

## Otros lenguajes de programación

Podrian resolver el mismo problema con Python, JavaScript o C++, utilizando un diccionario y un ciclo for, ademas que todos tienen la misma complejidad. Entonces escogi usar prolog, ya que como es un lenguaje logico.

- Mejor caso en cualquier lenguaje O(1): La primera letra no tiene transicion y el programa falla al momento.
  
- Caso promedio O(n): Una palabra que no sea valida y que comparte varias letras con las palabras del lenguaje, hara que recorrer n-1 letras antes de fallar.
  
- Peor caso O(n): Una palabra valida, en este caso anarya donde se recorren todas las letras hasta llegar a la aceptacion.
- 
## Referencias

Expresiones regulares - JavaScript | MDN. (2024). https://developer.mozilla.org/es/docs/Web/JavaScript/Guide/Regular_expressions

Quenya. Omniglot.com. Recuperado el 18 de marzo de 2026, de https://www.omniglot.com/conscripts/tengwar.htm

Fandom.com. Recuperado el 18 de marzo de 2026, de https://lotr.fandom.com/wiki/Quenya

NFA vs  DFA  desentranar las diferencias en los modelos de automata finitos - FasterCapital. (2025) FasterCapital. https://fastercapital.com/es/contenido/NFA-vs--DFA--desentranar-las-diferencias-en-los-modelos-de-automata-finitos.html#Comprender-los-modelos-de-aut-mata-finitos

Geeks for Geeks. (30 de noviembre, 2023). Regular Expression (RegEx) in Python with Examples. https://www.geeksforgeeks.org/regular-expression-python-examples/

Wikipedia. (19 de enero, 2024). Quenya. https://en.wikipedia.org/wiki/Quenya
