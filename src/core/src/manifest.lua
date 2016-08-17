local manifest = {}

local function dirname (path)
	if path:match(".-/.-") then
		return path:gsub ("(.*/)(.*)", "%1")
	end

	return ""
end

manifest.dirname = { ... }
manifest.dirname = dirname (manifest.dirname[2])

local function is_file (filename)
	local io = require ("io")
	local fd = io.open (filename, "r")

	if not fd then
		return false
	end

	fd:close ()

	return true
end

function manifest:load (module)
	if not is_file (self:dir_path () .. "/" .. module .. ".lua") then
		self.errormsg = "no such file or directory"
		return false
	end

	self.data = require ("manifest" .. "/" .. module)

	return true
end

function manifest:loadfile (file)
	if not is_file (file) then
		self.errormsg = "no such file or directory"
		return false
	end

	self.data = dofile (file)

	return true
end

function manifest:dir_path ()
	return self.dirname .. "/manifest"
end

function manifest:get_name ()
	return self.data.name
end

function manifest:get_version ()
	return self.data.version
end

function manifest:get_license ()
	return self.data.license
end

function manifest:get_author ()
	return self.data.author
end

function manifest:get_description ()
	return self.data.description
end

function manifest:get_usage ()
	return self.data.usage
end

function manifest:get_options ()
	return self.data.options
end

function manifest:get_error ()
	return self.errmsg
end

return manifest

