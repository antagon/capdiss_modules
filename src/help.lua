local help = {}

if #arg < 1 then
	error ("Missing a module name.")
end

local manifest = require ("manifest")

if not manifest[arg[1]] then
	error (("Module '%s' not found."):format (arg[1]))
end

local mod_manifest = dofile (manifest[arg[1]])

if not mod_manifest.usage then
	error ("No usage information available for this module.")
end

io.write (([[
%s

Usage: %s
]]):format (
	mod_manifest.description or "not-specified",
	mod_manifest.usage
))

if mod_manifest.options then
	io.write ("\nOptions:\n")

	for _, opt in pairs (mod_manifest.options) do
		io.write ((" %s\n"):format (opt))
	end
end

return help

