--  Extensions from lua api - Blitz Extensions
--  Copyright (C) 2017 - Fernando Batels <luisfbatels@gmail.com>

-- Split string by separator
function string:split(separator, max, b_regexp)
	assert(separator ~= '')
	assert(max == nil or max >= 1)

	local r = {}

	if self:len() > 0 then
		local plain = not b_regexp
		max = max or -1

		local num_field, num_start = 1, 1
		local num_first,num_last = self:find(separator, num_start, plain)
		while num_first and max ~= 0 do
			r[num_field] = self:sub(num_start, num_first-1)
			num_field = num_field+1
			num_start = num_last+1
			num_first,num_last = self:find(separator, num_start, plain)
			max = max-1
		end
		r[num_field] = self:sub(num_start)
	end

	return r
end

-- Return if string contains the paramter string
function string:contains(sub)
	return self:find(sub, nil, true) ~= nil
end

-- Trim string
function string:trim()
	return self:match('^%s*(.-)%s*$')
end

-- Remote multiple spaces and tri, string
function string:removemultispaces()
	return self:gsub('%s+', ' '):trim()
end

-- Return size of string
function string:length()
	return #self
end

-- Return if string starts with paramter
function string:startswith(substr)
	return self:sub(1, #substr) == substr
end

-- Return if string ends with paramter
function string:endswith(substr)
	return self:sub(-#substr) == substr
end

-- Append paramter to string
function string:append(post)
	return self..post
end

-- Upercase first char
function string:ucfirst()
	return self:sub(1, 1):upper()..self:sub(2)
end

-- Lowercase first char
function string:uclower()
	return self:sub(1, 1):lower()..self:sub(2)
end

-- Captalize the string
function string:capitalize()
	local res = {}
	
	self = self:lower()

	for _, val in ipairs(self:split(' ')) do
		res[#res + 1] = val:ucfirst()
	end

	return table.concat(res, ' ')
end

-- Return if string is empty
function string:isempty()
	return self == ''
end

-- Replace ocurrences on string
function string:replace(from, to)

	return self:gsub(from, to)
end

-- Check if file exists
function io.exists(path)

	local f = io.open(path, "r")

	if f ~= nil then
		io.close(f)
		return true
	end

	return false
end

-- Return table with lines of file
function io.linesfrom(path)
	if not io.exists(path) then return {} end

	lines = {}

	for line in io.lines(path) do 
		lines[#lines + 1] = line
	end

	return lines
end

-- Write lines(table) on file
function io.linesto(path, lines)
	local file = io.open(path, "w")
	
	for i, v in pairs(lines) do
		file:write(v .. "\n")
		file:flush()
	end
	
	file:close()
end

-- Return all content o file
function io.contentsfrom(path)
	return table.concat(io.linesfrom(path), "\n")
end

-- Write content on file
function io.contentsto(path, contents)
	local file = io.open(path, "w")
	
	file:write(contents)
	
	file:flush()
	file:close()
end

-- Alias to coroutine
function thread(run)
	coroutine.resume(coroutine.create(run))
end

-- Force current routine/thread wait
function sleep(s)
	local ntime = os.time() + s
	repeat until os.time() > ntime
end

-- Return position indez of value on table
function table.indexof(self, val)
	for index, value in pairs(self) do
		--~ print(index, value, val, value == val, type(val), type(value), #value, #val)
		if value == val then
			return index
		end
	end

	return 0
end

-- Return if table contains the value
function table.contains(self, val)
	return table.indexof(self, val) > 0
end

