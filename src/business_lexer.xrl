Definitions.

VAR   = ([A-Za-z_][0-9a-zA-Z_]*)
WS    = ([\000-\s]|%.*)

Rules.

false   : {token, {false,   TokenLine}}.
true    : {token, {true,    TokenLine}}.

and     : {token, {and_op,  TokenLine, list_to_atom(TokenChars)}}.

{VAR}   : {token, {var,     TokenLine, list_to_binary(TokenChars)}}.
{WS}+   : skip_token.

Erlang code.
