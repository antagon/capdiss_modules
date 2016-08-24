local lfs = require ("lfs")

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

local manifest = require ("manifest")

for _, file in ipairs (find_manifests (manifest:dir_path ())) do
	file = file:gsub (".lua$", "")

	if not manifest:load (file) then
		error (("Cannot load manifest file for module '%s': %s"):format (file, manifest:get_error ()))
	end

	io.write (("%s - %s\n"):format (manifest:get_name (), manifest:get_description () or "no description available"))
end

