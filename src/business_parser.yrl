Nonterminals expression bool.

Terminals var and_op true false.

Rootsymbol expression.

expression -> bool : '$1'.
expression -> var : extract('$1').

expression -> expression and_op expression  : {binary_expr, and_op, '$1', '$3'}.

bool -> true : true.
bool -> false : false.

Erlang code.

extract({T,_,V}) -> {T, V}.
