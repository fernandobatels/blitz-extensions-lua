
--  Extensions from lua api - Blitz Extensions
--  Copyright (C) 2016 - Fernando Batels <luisfbatels@gmail.com>

--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License.

--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.

--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <http://www.gnu.org/licenses/>.

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

function string:i_split(separator, max, b_regexp)
	local r = {}
	
	local counter = 1
	for k, v in pairs(self:lower():split(separator:lower(), max, b_regexp)) do
		
		table.insert(r, self:sub(counter, counter + v:length() - 1))
		counter = counter + v:length() + separator:length()
	end
	
	return r
end

function string:contains(sub)
	return self:find(sub, nil, true) ~= nil
end

function string:trim()
	return self:match('^%s*(.-)%s*$')
end

function string:remove_multispaces()
	return self:gsub('%s+', ' '):trim()
end

function string:length()
	return #self
end

function string:starts_with(substr)
	return self:sub(1, #substr) == substr
end

function string:ends_with(substr)
	return self:sub(-#substr) == substr
end

function string:append(post)
	return self..post
end


function string:uc_first()
	return self:sub(1, 1):upper()..self:sub(2)
end

function string:uc_lower()
	return self:sub(1, 1):lower()..self:sub(2)
end

function string:capitalize()
	local res = {}
	
	self = self:lower()

	for _, val in ipairs(self:split(' ')) do
		res[#res + 1] = val:uc_first()
	end

	return table.concat(res, ' ')
end


function string:is_empty()
	return self == ''
end

function string:replace(from, to)

	return self:gsub(from, to)
end

function io.exists(path)

	local f = io.open(path, "r")

	if f ~= nil then
		io.close(f)
		return true
	end

	return false
end

function io.lines_from(path)
	if not io.exists(path) then return {} end

	lines = {}

	for line in io.lines(path) do 
		lines[#lines + 1] = line
	end

	return lines
end

function io.lines_to(path, lines)
	local file = io.open(path, "w")
	
	for i, v in pairs(lines) do
		file:write(v .. "\n")
		file:flush()
	end
	
	file:close()
end

function io.contents_from(path)
	return table.concat(io.lines_from(path), "\n")
end

function io.contents_to(path, contents)
	local file = io.open(path, "w")
	
	file:write(contents)
	
	file:flush()
	file:close()
end

function thread(run)
	coroutine.resume(coroutine.create(run))
end

function sleep(s)
	local ntime = os.time() + s
	repeat until os.time() > ntime
end

