Nonterminals expression bool.

Terminals and_op true false.

Rootsymbol expression.


expression -> bool : '$1'.

expression -> expression and_op expression  : {binary_expr, and_op, '$1', '$3'}.

bool -> true : true.
bool -> false : false.

Erlang code.

unwrap({_,_,V}) -> V.
