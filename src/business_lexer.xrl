Definitions.
WS    = ([\000-\s]|%.*)

Rules.
false   : {token, {false,   TokenLine}}.
true    : {token, {true,    TokenLine}}.

and     : {token, {and_op,  TokenLine, list_to_atom(TokenChars)}}.

{WS}+   : skip_token.

Erlang code.
