#!/usr/bin/env lua

-------------------------------------------------------------------
--  Ceci est une implémentation basique du langage Forth en Lua  --
-------------------------------------------------------------------


--
--  Données
---------------

local stack        = {} -- pile d'exécution
local symbol_table = {} -- table des symboles (fonctions)

--
--  Procédures
------------------

local push, pop, dispatch, main_loop

-- pop(n)        --> dépile les n dernières valeurs de la pile `stack`
-- push(a, ...)  --> empile toutes les valeurs passées en paramètre dans `stack`
-- dispatch(...) --> procédure appelée pour dispatcher les symboles lus
-- main_loop()   --> exécute la boucle principale

local make_dispatch_execute_until
local make_dispatch_skip_until

--
--  Implémentation des fonctions de base de Forth
-----------------------------------------------------

symbol_table.DUP = function(...)
  local a = pop()
  push(a, a)
end -- DUP

symbol_table['*'] = function(...)
  local a, b = pop(2)
  push(a * b)
end -- '*'

symbol_table['-'] = function(...)
  local a, b = pop(2)
  push(a - b)
end -- '-'

symbol_table['+'] = function(...)
  local a, b = pop(2)
  push(a + b)
end -- '+'

symbol_table['/'] = function(...)
  local a, b = pop(2)
  push(a / b)
end -- '/'

symbol_table.NEG = function(...)
  local a = pop()
  push(a * -1)
end -- NEG

symbol_table['.'] = function(...)
  io.write(tostring(pop()), " ")
end -- '.'

symbol_table.STACK = function(...)
  for i = 1, #stack do
    io.write(tostring(stack[i]), " ")
  end
end -- STACK

symbol_table['<='] = function(...)
  local a, b = pop(2)
  push(a <= b)
end -- less/equal

symbol_table['<'] = function(...)
  local a, b = pop(2)
  push(a < b)
end -- less

symbol_table['>='] = function(...)
  local a, b = pop(2)
  push(a >= b)
end -- greater/equal

symbol_table['>'] = function(...)
  local a, b = pop(2)
  push(a > b)
end -- greater

symbol_table.IF = function(original_dispatcher)
  if pop() then
    return make_dispatch_execute_until(original_dispatcher, "ELSE",
      make_dispatch_skip_until("THEN",
        original_dispatcher))
  else
    return make_dispatch_skip_until("ELSE",
      make_dispatch_execute_until(original_dispatcher, "THEN",
        original_dispatcher))
  end
end -- IF/ELSE

--
--  Dispatch
----------------

-- dispatcher takes:
--   disp: the current dispatcher function
--   word: a string to process
-- it can return a function value which will replace the actual dispatcher.

function dispatch(disp, word)
  -- print(word)

  if symbol_table[word] then      -- Si `word` est dans la table des symboles,
                                  -- appeler la fonction correspondante
    return symbol_table[word](disp)
  
  elseif word:find("^%d+$") then  -- Si c'est un nombre, empiler `word`
    push(tonumber(word))

  else                            -- Sinon, erreur
    error(word.." invalid symbol")

  end
end -- dispatch

--
--  Dispatcher Factories
----------------------------

function make_dispatch_execute_until(original_dispatcher, until_word, after_dispatcher)
  return function(disp, word)
    if word == until_word then
      return after_dispatcher
    else
      return original_dispatcher(disp, word)
    end
  end
end -- make_dispatch_execute_until

function make_dispatch_skip_until(until_word, after_dispatcher)
  return function(disp, word)
    if word == until_word then
      return after_dispatcher
    end
  end
end -- make_dispatch_skip_until

--
--  Boucle principale
-------------------------

function main_loop()
  local input = true
  local disp = dispatch
  while input do
    io.write("> ")
    io.flush()
    input = io.read()
    if input then
      local res, msg = pcall(function()
        for word in string.gmatch(input, "%s*(%S+)%s*") do
          local res = disp(disp, word)
          if res ~= nil then
            disp = res
          end
        end
      end)
      if res then
        io.write("ok\n")
      else
        io.write(msg, "\n")
      end
    end
  end
end -- main_loop

--
--  Fonctions concernant la pile
------------------------------------

function pop(n)
  assert(#stack > 0, "stack is empty")
  if n == nil or n == 1 then
    return table.remove(stack)
  else
    local last    = pop(1)
    local res     = { pop(n-1) }
    res[#res + 1] = last
    return table.unpack(res)
  end
end -- pop

function push(...)
  for i = 1, select("#", ...) do
    stack[#stack+1] = select(i, ...)
  end
end -- push

--
--  Exécution
-----------------

-- Compatibilité Lua 5.1 / 5.2
if unpack and not table.unpack then
  table.unpack = unpack
end

-- Exécution
main_loop()

