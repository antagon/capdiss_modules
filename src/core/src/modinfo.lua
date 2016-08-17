local modinfo = {}

if #arg < 1 then
	error ("Missing a module name.")
end

local manifest = require ("manifest")

if not manifest:load (arg[1]) then
	error (("Module '%s' not found."):format (arg[1]))
end

io.write (([[
Name: %s
Version: %s
Author: %s
License: %s
Description: %s
]]):format (
	manifest:get_name () or "not-specified",
	manifest:get_version () or "not-specified",
	manifest:get_author () or "not-specified",
	manifest:get_license () or "not-specified",
	manifest:get_description () or "not-specified"
))

return modinfo

