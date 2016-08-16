require ("print/format")

return function (packet, ts, num)
	if packet:is_request () then
		io.write (("%s %s %4s HTTP/%s %s %s\n"):format (
					format_pktnum (num),
					format_timestamp (ts),
					packet:type ():upper (),
					packet:get_version (),
					packet:get_method (),
					packet:get_uri ()
					))
	else
		io.write (("%s %s %4s HTTP/%s %s\n"):format (
					format_pktnum (num),
					format_timestamp (ts),
					packet:type ():upper (),
					packet:get_version (),
					packet:get_response ()
					))
	end
end

