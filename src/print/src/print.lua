require ("coroner.getopt")

local show_eth = false

for opt, arg in getopt ("e", arg) do
	if opt == "e" then
		show_eth = true
	end
end

local coroner = require ("coroner")
local app = coroner.new_app (coroner.app.type.DISSECTOR)

local hooks = {
	-- Trigger for each input file...
	["@"] = function (filename, linktype)
		io.stderr:write (("reading from file %s, link-type %s\n"):format (filename, linktype))
	end,

	["?"] = require ("print/print_unknown"),
	["ip"] = require ("print/print_ip"),
	["ipv6"] = require ("print/print_ipv6"),
	["icmp"] = require ("print/print_icmp"),
	["tcp"] = require ("print/print_tcp"),
	["udp"] = require ("print/print_udp"),
	["http"] = require ("print/print_http")
}

-- Show Ethernet header
if show_eth then
	hooks["eth"] = require ("print/print_eth")
end

if not app:set_hooks (hooks) then
	error (app:get_error ())
end

app:set_sigaction (function ()
	print ("Signal caught.")
end)

return app:run ()

