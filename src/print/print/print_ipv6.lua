require ("print/format")

return function (packet, ts, num)
	io.write (("%s %s %4s %s > %s\n"):format (
					format_pktnum (num),
					format_timestamp (ts),
					packet:type ():upper (),
					packet:get_saddr ():color ("brgreen", nil, true),
					packet:get_daddr ():color ("brgreen", nil, true)))
end

