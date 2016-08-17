local lfs = require ("lfs")

local modlist = {}

local manifest = require ("manifest")

for file in lfs.dir (manifest:dir_path ()) do
	file = manifest:dir_path () .. "/" .. file

	if lfs.attributes (file, "mode") == "file" then
		if not manifest:loadfile (file) then
			error (("Cannot load manifest file '%s'"):format (file))
		end

		io.write (("%s - %s\n"):format (manifest:get_name (), manifest:get_description () or "no description available"))
	end
end

return modlist

