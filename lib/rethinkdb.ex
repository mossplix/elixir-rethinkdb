defmodule Rethinkdb do
  alias Rethinkdb.Connection
  alias Rethinkdb.Rql




  defmodule RqlDriverError do
    defexception message: nil

     def not_implemented(method) do
          reraise(RqlDriverError, msg: "#{method} not implemented yet")
        end



         def exception(type: type,msg: msg) do
             %__MODULE__{message: "#{type}: #{msg}"}
          end
  end







  defmacro __using__(_opts) do
    helper(__CALLER__.module)
  end

  def start do
    Rethinkdb.App.start
  end

  # Import rr in Iex to not conflict Iex.Helper.r
  defp helper(module) do
    method = module && :r || :rr
    quote do
      import(Rql, only: [{unquote(method), 0}])
      alias unquote(__MODULE__).RqlDriverError
      alias unquote(__MODULE__).RqlRuntimeError
    end
  end
end
