require ("print/format")

return function (packet, ts, num)
	io.write (("%s %s %4s %s\n"):format (
				format_pktnum (num),
				format_timestamp (ts),
				"???",
				("Dissector for this protocol is not available."):color ("brred")
	))
end

