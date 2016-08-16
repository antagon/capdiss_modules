require ("print/format")

return function (packet, ts, num)
	io.write (("%s %s %4s %s > %s: length %d\n"):format (
				format_pktnum (num),
				format_timestamp (ts),
				packet:type ():upper (),
				tostring (packet:get_srcport ()):color ("brcyan", nil),
				tostring (packet:get_dstport ()):color ("brcyan", nil),
				packet:get_datalen ()
				))
end

