require ("coroner.getopt")
local search = {}

local search_opt = ""
local match_string = nil

for opt, arg in getopt ("ndal", arg) do
	if not opt then
		match_string = arg
	elseif opt == "?" then
		error ("Undefined option '-" .. arg .. "'.")
	else
		search_opt = opt
	end
end

if not match_string then
	error ("Missing a string to match.")
end

if #search_opt == 0 then
	search_opt = "nd"
end

local manifest = require ("manifest")

for _, mod_manifest in pairs (manifest) do
	local mod = dofile (mod_manifest)
	local field = ""

	for i = 1, #search_opt do
		if search_opt:sub (i, i) == "n" then
			field = mod.name
		elseif search_opt:sub (i, i) == "d" then
			field = mod.description
		elseif search_opt:sub (i, i) == "a" then
			field = mod.author
		elseif search_opt:sub (i, i) == "l" then
			field = mod.license
		end

		local match_beg, match_end = string.find (field:lower (), match_string:lower ())

		if match_beg then
			io.write (("%s - %s\n"):format (mod.name, mod.description))
			break
		end
	end
end

return search

