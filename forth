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

