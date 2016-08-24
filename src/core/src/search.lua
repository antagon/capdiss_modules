local lfs = require ("lfs")
require ("coroner.getopt")

local function merge_tables (t1, t2)
	for _, v in pairs (t2) do
		table.insert (t1, v)
	end

	return t1
end

local function find_manifests (dirname, prefix)
	local files = {}

	if prefix then
		prefix = prefix .. "/"
	else
		prefix = ""
	end

	for file in lfs.dir (dirname) do
		if file ~= "." and file ~= ".." then
			local path = dirname .. "/" .. file
			local ftype = lfs.attributes (path, "mode")

			if ftype == "file" then
				table.insert (files, prefix .. file)
			elseif ftype == "directory" then
				merge_tables (files, find_manifests (path, prefix .. file))
			end
		end
	end

	return files
end

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
	error ("No search pattern specified.")
end

if #search_opt == 0 then
	search_opt = "nd"
end

local manifest = require ("manifest")

for _, file in ipairs (find_manifests (manifest:dir_path ())) do
	file = file:gsub (".lua$", "")

	if not manifest:load (file) then
		error (("Cannot load manifest file for module '%s': %s"):format (file, manifest:get_error ()))
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

