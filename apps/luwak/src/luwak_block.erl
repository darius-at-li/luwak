-module(luwak_block).

-include_lib("luwak/include/luwak.hrl").

-export([create/2,
         data/1,
         name/1]).

create(Riak, Data) ->
    Value = [
             {data, Data},
             {created, now()},
             {type, block}
            ],
    Obj = riak_object:new(?N_BUCKET, skerl:hexhash(?HASH_LEN, Data), Value),
    {Riak:put(Obj,2), Obj}.
  
data(Val) when is_list(Val) ->
    proplists:get_value(data, Val);
data(Object) ->
    proplists:get_value(data, riak_object:get_value(Object)).

name(Object) ->
    riak_object:key(Object).
