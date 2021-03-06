local skynet = require "skynet"
local redis = require "redis"

skynet.start(function()
	local db = redis.connect "main"
	print(db:select(0))
	db:batch "write"	-- ignore results
		db:set("A", "hello")
		db:set("B", "world")
		db:sadd("C", "one")
	print(db:batch "end")

	db:batch "read"
		db:get("A")
		db:get("B")
	local r = db:batch "end" -- return all results in a table
	for k,v in pairs(r) do
		print(k,v)
	end
	print(db:exists "A")
	print(db:get "A")
	print(db:set("A","hello world"))
	print(db:get("A"))
	print(db:sismember("C","one"))
	print(db:sismember("C","two"))
	db:disconnect()
	skynet.exit()
end)

