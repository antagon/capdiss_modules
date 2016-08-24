return {
	name = "search",
	version = "1.0",
	license = "GPLv2",
	author = "antagon <antagon@codeward.org>",
	description = "Search for a module by string.",
	usage = "search [options] <pattern>",
	options = {
		"-n match only the module names",
		"-d match only text in module descriptions",
		"-a match only author names",
		"-l match only the license names"
	}
}
