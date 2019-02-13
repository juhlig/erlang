-module('tgen_phone-number').

-behaviour(tgen).

-export([
    available/0,
    generate_test/2
]).

-spec available() -> true.
available() ->
    true.

generate_test(N, #{description := Desc, expected := #{error := _}, property := Prop, input := #{phrase := Phrase}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertError", [
            tgs:var("_"),
            tgs:call_fun("phone_number:" ++ Property, [
                tgs:value(binary_to_list(Phrase))])])]),

    {ok, Fn, [{Property, ["String"]}]};
generate_test(N, #{description := Desc, expected := Exp, property := Prop, input := #{phrase := Phrase}}) ->
    TestName = tgen:to_test_name(N, Desc),
    Property = tgen:to_property_name(Prop),

    Fn = tgs:simple_fun(TestName, [
        tgs:call_macro("assertEqual", [
            tgs:value(binary_to_list(Exp)),
            tgs:call_fun("phone_number:" ++ Property, [
                tgs:value(binary_to_list(Phrase))])])]),

    {ok, Fn, [{Property, ["String"]}]}.
