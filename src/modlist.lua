local modlist = {}

local manifest = require ("manifest")

for _, mod_manifest in pairs (manifest) do
	local mod = dofile (mod_manifest)

	io.write (("%s - %s\n"):format (mod.name, mod.description or "no description available"))
end

return modlist

