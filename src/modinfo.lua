local modinfo = {}

if #arg < 1 then
	error ("Missing a module name.")
end

local manifest = require ("manifest")

if not manifest[arg[1]] then
	error (("Module '%s' not found."):format (arg[1]))
end

local mod_manifest = dofile (manifest[arg[1]])

io.write (([[
Name: %s
Version: %s
Author: %s
License: %s
Description: %s
]]):format (
	mod_manifest.name or "not-specified",
	mod_manifest.license or "not-specified",
	mod_manifest.version or "not-specified",
	mod_manifest.author or "not-specified",
	mod_manifest.description or "not-specified"
))

return modinfo

