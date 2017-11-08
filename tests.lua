
require "extensions"

local a = "a b c  d  1 23 "

assert(a:split(" ")[1] == "a")

assert(a:split("B")[1] ~= "a ")

assert(a:contains("b"))

assert(a:trim("a b c  d  1 23"))

assert(a:removemultispaces("a b c d 1 23 "))

assert(a:length() == 15)

assert(a:startswith("a"))

assert(a:endswith(" "))

assert(a:ucfirst():startswith("A"))

assert(a:ucfirst():uclower():startswith("a"))

assert(a:capitalize():startswith("A B "))

assert(a:isempty() == false)

io.contentsto('test-file.txt', '123')

assert(io.exists('test-file.txt'))

assert(io.contentsfrom('test-file.txt') == '123')

local b = {}

b[1] = 'a'
b[2] = 'b'
b[3] = 'c'

assert(table.contains(b, 'j') == false)

assert(table.contains(b, 'c'))

assert(table.indexof(b, 'c') == 3)
