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

local function conv_timestamp (ts)
	return ("%s.%06d"):format (os.date ("%H:%M:%S", ts), (ts % 1) * 1000000)
end

local hooks = {
	-- Trigger for each input file...
	["@"] = function (filename, linktype)
		io.stderr:write (("reading from file %s, link-type %s\n"):format (filename, linktype))
	end,

	ip = function (packet, ts, num)
		io.write (("%06d %s %4s %s -> %s\n"):format (
					num,
					conv_timestamp (ts),
					packet:type ():upper (),
					packet:get_saddr ():color ("brgreen", nil, true),
					packet:get_daddr ():color ("brgreen", nil, true)))
	end,

	ipv6 = function (packet, ts, num)
		io.write (("%06d %s %4s %s -> %s\n"):format (
					num,
					conv_timestamp (ts),
					packet:type ():upper (),
					packet:get_saddr ():color ("brgreen", nil, true),
					packet:get_daddr ():color ("brgreen", nil, true)))
	end,

	icmp = function (packet, ts, num)
		local line

		-- ICMP ECHO Request/Response
		if packet:get_type () == packet.types.ICMP_ECHO or packet:get_type () == packet.types.ICMP_ECHOREPLY then
			line = ("%06d %s %4s %s (%d), id %d, seq %d"):format (
						num,
						conv_timestamp (ts),
						packet:type ():upper (),
						packet:get_type_str (),
						packet:get_type (),
						packet:get_id (),
						packet:get_seqnum ()
			)
		else
			line = ("%06d %s %4s %s (%d)"):format (
						num,
						conv_timestamp (ts),
						packet:type ():upper (),
						"AAA",
						packet:get_type ()
			)
		end

		io.write (line .. "\n")
	end,

	tcp = function (packet, ts, num)
		io.write (("%06d %s %4s %s -> %s: Flags [%s], seq %d, ack %d, win %d, options [%s], length %d\n"):format (
					num,
					conv_timestamp (ts),
					packet:type ():upper (),
					tostring (packet:get_srcport ()):color ("brcyan", nil),
					tostring (packet:get_dstport ()):color ("brcyan", nil),
					tcp_flgs2str (packet),
					packet:get_seqnum (),
					packet:get_acknum (),
					packet:get_winsize (),
					"TODO",
					packet:get_datalen ()
					))
	end,

	udp = function (packet, ts, num)
		io.write (("%06d %s %4s %s -> %s: length %d\n"):format (
					num,
					conv_timestamp (ts),
					packet:type ():upper (),
					tostring (packet:get_srcport ()):color ("brcyan", nil),
					tostring (packet:get_dstport ()):color ("brcyan", nil),
					packet:get_datalen ()
					))
	end
}

if not app:set_hooks (hooks) then
	error (app:get_error ())
end

app:set_sigaction (function ()
	print ("Signal caught.")
end)

return app:run ()

