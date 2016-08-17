local help = {}

if #arg < 1 then
	error ("Missing a module name.")
end

local manifest = require ("manifest")

if not manifest:load (arg[1]) then
	error (("Module '%s' not found."):format (arg[1]))
end

if not manifest:get_usage () then
	error ("No usage information available for this module.")
end

io.write (([[
%s

Usage: %s
]]):format (
	manifest:get_description () or "not-specified",
	manifest:get_usage ()
))

if manifest:get_options () then
	io.write ("\nOptions:\n")

	for _, opt in pairs (manifest:get_options ()) do
		io.write ((" %s\n"):format (opt))
	end
end

return help

