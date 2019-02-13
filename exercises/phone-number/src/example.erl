-module(example).

-export([clean/1]).

clean(String) ->
    String1=normalize(String),
    String2=sanitize1(String1),
    sanitize2(String2).

normalize(String) -> [C || C <- String, C>=$0, C=<$9].

sanitize1(String) when length(String)=:=10 -> String;
sanitize1([$1|String]) when length(String)=:=10 -> String.

sanitize2(String=[A, _, _, D|_]) when A=/=$0, A=/=$1, D=/=$0, D=/=$1 -> String.
