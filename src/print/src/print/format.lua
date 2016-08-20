local math = require ("math")
local os = require ("os")

function format_pktnum (num)
	return ("%06d"):format (num)
end

function format_timestamp (ts)
	return ("%s.%06d"):format (os.date ("%H:%M:%S", math.floor (ts)), math.floor ((ts % 1) * 1000000))
end

