local modlist = {}

local manifest = require ("manifest")

for _, mod in pairs (manifest) do
	io.write (mod .. "\n")
end

return modlist

