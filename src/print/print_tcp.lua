require ("print/format")

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

return function (packet, ts, num)
	io.write (("%s %s %4s %s > %s: Flags [%s], seq %d, ack %d, win %d, options [%s], length %d\n"):format (
				format_pktnum (num),
				format_timestamp (ts),
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
end

