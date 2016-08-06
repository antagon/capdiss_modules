local modinfo = {}

if #arg < 1 then
	error ("Missing a module name.")
end

local ifile = arg[1] .. "-manifest"

local fd = io.open (ifile .. ".lua")

if not fd then
	error (("Module '%s' not found."):format (arg[1]))
end

fd:close ()

local manifest = require (ifile)

io.write (([[
name: %s
license: %s
version: %s
author: %s
description: %s
usage: %s
]]):format (
	manifest.name or "not-specified",
	manifest.license or "not-specified",
	manifest.version or "not-specified",
	manifest.author or "not-specified",
	manifest.description or "not-specified",
	manifest.usage or "not-specified"
))

return modinfo

