require ("coroner.getopt")
local lfs = require ("lfs")

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

for file in lfs.dir (manifest:dir_path ()) do
	file = manifest:dir_path () .. "/" .. file

	if lfs.attributes (file, "mode") == "file" then
		if not manifest:loadfile (file) then
			error (("Cannot load manifest file '%s'"):format (file))
		end

		local field = ""

		for i = 1, #search_opt do
			if search_opt:sub (i, i) == "n" then
				field = manifest:get_name ()
			elseif search_opt:sub (i, i) == "d" then
				field = manifest:get_description ()
			elseif search_opt:sub (i, i) == "a" then
				field = manifest:get_author ()
			elseif search_opt:sub (i, i) == "l" then
				field = manifest:get_license ()
			end

			if string.match (field:lower (), match_string:lower ()) then
				io.write (("%s - %s\n"):format (manifest:get_name (), manifest:get_description ()))
				break
			end
		end
	end
end

return search

