# Context-Free Grammars
## Python if
```Python
if age >= 18:
    print("You are allowed to go to the party")
elif age < 10:
    print ("Is this OK?")
else:
    print("You are underage")
```

**Backus-Naur Form**
```BNF
<conditional> ::= <if>|<if><elif-sequence>|<if><elif-sequence><else>|<if><else>
<if> ::= if <expression>:\n\t<code>
<elif-sequence> ::= <elif>|<elif><elif-sequence>
<elif> ::= elif <expression>:\n\t<code>
<else> ::=else\n\t<code>
```

**Extended Backus-Naur Form**
```bash
CONDITIONAL ::= IF [{ELIF}]|[ELSE]
IF ::= 'if' EXPRESSION ':\n\t' CODE
ELIF ::= 'elif' EXPRESSION ':\n\t' CODE
ELSE ::= 'else:\n\t' CODE
```