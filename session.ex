▶ iex
Erlang/OTP 21 [erts-10.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

Interactive Elixir (1.7.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> x = 1
1
iex(2)> 1 = x
1
iex(3)> 2 = x
** (MatchError) no match of right hand side value: 1
(stdlib) erl_eval.erl:453: :erl_eval.expr/5
  (iex) lib/iex/evaluator.ex:249: IEx.Evaluator.handle_eval/5
  (iex) lib/iex/evaluator.ex:229: IEx.Evaluator.do_eval/3
  (iex) lib/iex/evaluator.ex:207: IEx.Evaluator.eval/3
  (iex) lib/iex/evaluator.ex:94: IEx.Evaluator.loop/1
  (iex) lib/iex/evaluator.ex:24: IEx.Evaluator.init/4
iex(3)> File.read("some/path/test.txt")
{:error, :enoent}
iex(4)> File.read("./nitish.txt")
{:ok, "helo\n"}
iex(6)> {:ok, cnt} = File.read("./nitish.txt")
{:ok, "helo\n"}
iex(7)> {:ok, cnt} = File.read("./nitish_.txt")
** (MatchError) no match of right hand side value: {:error, :enoent}
(stdlib) erl_eval.erl:453: :erl_eval.expr/5
  (iex) lib/iex/evaluator.ex:249: IEx.Evaluator.handle_eval/5
  (iex) lib/iex/evaluator.ex:229: IEx.Evaluator.do_eval/3
  (iex) lib/iex/evaluator.ex:207: IEx.Evaluator.eval/3
  (iex) lib/iex/evaluator.ex:94: IEx.Evaluator.loop/1
  (iex) lib/iex/evaluator.ex:24: IEx.Evaluator.init/4
iex(7)> defmodule User do
...(7)> defstruct([:name])
...(7)> end
iex(8)> u = %User{name: "Nitish"}
%User{name: "Nitish"}
iex(9)> u.name
"Nitish"
iex(10)> defmodule Product do
...(10)> defstruct([:name])
...(10)> end
iex(11)> p = %Product{name: "iPhone"}
%Product{name: "iPhone"}
iex(13)> printer = fn
...(13)    %User{} = u -> IO.puts("Hello, #{u.name}")
...(13)>   %Product{} = p -> IO.puts("Nice - #{p.name}")
...(13)> end
#Function<6.128620087/1 in :erl_eval.expr/5>
iex(14)> printer.(u)
Hello, Nitish
:ok
iex(15)> printer.(p)
Nice - iPhone
:ok
iex(16)> defmodule Printer do
...(16)> def print(%User{} = u), do: IO.puts("Hello, #{u.name}")
...(16)> end
iex(17)> Printer.print(u)
Hello, Nitish
:ok
iex(18)> Printer.print(p)
** (FunctionClauseError) no function clause matching in Printer.print/1


#### CONCURRENCY and PROCESSES

iex(18)> pid = spawn(fn -> IO.puts "Hello" end)
Hello
#PID<0.155.0>
iex(19)> pid
#PID<0.155.0>
iex(20)> Process.alive?(pid)
false
iex(21)> self()
#PID<0.105.0>
iex(22)> send self(), "Hello"
"Hello"
iex(23)> send self(), "Hello 2"
"Hello 2"
iex(24)> send self(), "Hello 3"
"Hello 3"
iex(25)> flush()
"Hello"
"Hello 2"
"Hello 3"
:ok
iex(26)> flush()
:ok
iex(27)> receive do
...(27)>   msg -> IO.inspect(msg)
...(27)> end

# IEX HANDS UNDEFINITELY - QUITTING
#
iex(1)> send self(), "Hello"
"Hello"
iex(2)> receive do
...(2)>   msg -> IO.inspect(msg)
...(2)> end
"Hello"
"Hello"
iex(3)> pid = spawn(fn ->
...(3)>   receive do
...(3)>     str -> str |> String.upcase() |> IO.inspect()
...(3)>   end
...(3)> end)
#PID<0.115.0>
iex(4)> Process.alive?(pid)
true
iex(5)> send pid, "nitish"
"nitish"
"NITISH"
iex(6)> Process.alive?(pid)
false
iex(7)> send pid, {self(), "My argument"}
{#PID<0.105.0>, "My argument"}
iex(8)> pid = spawn(fn ->
...(8)>   receive do
...(8)>     {sender, arg} -> send(sender, arg |> String.upcase())
...(8)>   end
...(8)> end)
#PID<0.125.0>
iex(9)> send pid, {self(), "My argument"}
{#PID<0.105.0>, "My argument"}
iex(10)> flush
"MY ARGUMENT"
:ok
