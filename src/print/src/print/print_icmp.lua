require ("print/format")

return function (packet, ts, num)
	local line

	-- ICMP ECHO Request/Response
	if packet:get_type () == packet.types.ICMP_ECHO or packet:get_type () == packet.types.ICMP_ECHOREPLY then
		line = ("%s %s %4s %s (%d), id %d, seq %d"):format (
					format_pktnum (num),
					format_timestamp (ts),
					packet:type ():upper (),
					packet:get_type_str (),
					packet:get_type (),
					packet:get_id (),
					packet:get_seqnum ()
		)
	else
		line = ("%s %s %4s %s (%d)"):format (
					format_pktnum (num),
					format_timestamp (ts),
					packet:type ():upper (),
					packet:get_type_str (),
					packet:get_type ()
		)
	end

	io.write (line .. "\n")
end

