local coroner = require ("coroner")
local app = coroner.new_app (coroner.app.type.DISSECTOR)

local function tcp_flgs2str (packet)
	local str = ""

	if packet:isset_fin () then
		str = "F"
	end

	if packet:isset_syn () then
		str = str .. "S"
	end

	if packet:isset_rst () then
		str = str .. "R"
	end

	if packet:isset_push () then
		str = str .. "P"
	end

	if packet:isset_ack () then
		str = str .. "."
	end

	if packet:isset_urg () then
		str = str .. "U"
	end

	if packet:isset_echo () then
		str = str .. "E"
	end

	if packet:isset_cwr () then
		str = str .. "W"
	end

	if #str == 0 then
		str = "none"
	end

	return str
end

local hooks = {
	-- Trigger for each input file...
	["@"] = function (filename, linktype)
		io.stderr:write (("reading from file %s, link-type %s\n"):format (filename, linktype))
	end,

	ip = function (packet, ts, num)
		io.write (("%s %s %s -> %s\n"):format (
					os.date ("%H:%M:%S", ts),
					packet:type ():upper (),
					packet:get_saddr ():color ("brgreen", nil, true),
					packet:get_daddr ():color ("brgreen", nil, true)))
	end,

	tcp = function (packet, ts, num)
		local flgs = tcp_flgs2str

		io.write (("%s %s %s -> %s: Flags [%s], seq %d, ack %d, win %d, options [%s], length %d\n"):format (
					os.date ("%H:%M:%S", ts),
					packet:type ():upper (),
					tostring (packet:get_srcport ()):color ("bryellow", nil),
					tostring (packet:get_dstport ()):color ("bryellow", nil),
					tcp_flgs2str (packet),
					packet:get_seqnum (),
					packet:get_acknum (),
					packet:get_winsize (),
					"TODO",
					packet:get_datalen ()
					))
	end,

	--[[ipv6 = function (packet, ts, num)
		print (("%s %s %s > %s"):format (
				os.date ("%H:%M:%S", ts),
				packet:type ():upper (),
				packet:get_saddr ():color ("brgreen", nil, true),
				packet:get_daddr ():color ("brgreen", nil, true)))
	end,

	udp = function (packet, ts, num)
		print (("%s %s %s > %s"):format (
				os.date ("%H:%M:%S", ts),
				packet:type ():upper (),
				packet:get_srcport (),
				packet:get_dstport ()))
	end,]]

	-- A signal handler...
	sigaction = function (signo)
		print ("Ooops... signal delivered...")
	end
}

if not app:set_hooks (hooks) then
	error (app:get_error ())
end

return app:run ()

