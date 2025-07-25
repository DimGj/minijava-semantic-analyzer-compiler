# compilers_project1

~ Part 1 ~

!Execute instructions:  > cd part1
                        > make all
                        > make run

In order to eliminate the left recursion as the exercise suggests i refactored the grammar.
We used this transformation: A → A α | β  to:  A  → β A'
                                               A' → α A' | ε

So in our case we ve got now: exp  → term exp2
                              exp2 → + term exp2 | - term exp2 | ε
Also since operators have different priority each , we split th exponent too like this: term   → factor term2
                                                                                        term2  → ** factor term2 | ε
                                                                                        factor     → num | (exp)
So now term holds higher priority for exponent elements.
Last we need to make the repitition explicit for num (composed of digits) so:   num  → digit num2
                                                                                num2 → digit num2 | ε

The digit rule remains the same: digit  →  0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

So our new grammar is:  exp     →  term exp2
                        exp2    →  + term exp2 | - term exp2 | ε
                        term    →  factor term2
                        term2   →  ** factor term2 | ε
                        factor  →  num | (exp)
                        num     →  digit num2
                        num2    →  digit num2 | ε
                        digit   →  0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

This grammar now can be LL(1) and that is what is implemented on Calculator.java
Furthermore its first and follow sets (starting from digit and  till the complex tokens of exp):
        TOKEN	         FIRST	                FOLLOW
        digit	        {0–9}	           {0–9, ), +, -, **, $}
        num	            {0–9}	           {), +, -, **, $}
        num2	        {0–9, ε}	       {), +, -, **, $}
        factor	        {0–9, (}	       {**, ), +, -, $}
        term	        {0–9, (}	       {), +, -, $}
        term2	        {**, ε}	           {), +, -, $}
        exp	            {0–9, (}	       {), $}
        exp2	        {+, -, ε}	       {), $}

~ Part 2 ~

!Execute instructions:  > cd part2
                        > make all
                        > make run

1. I have created a flex file that generates tokens to be processed by our cup file.
2. Adjusted and extended the cup file based on Example 2 from the lessons (added a method to generate class methods for our IR file).

During build the parser.java, sym.java and scanner.java files are generated. Could not test also if they were correct.

Issues Encountered:

a) I encountered an issue where java_cup could not be recognized during the build process.
b) I was unable to fully understand how to connect the IR output to real-time Java code via a main.java file.



