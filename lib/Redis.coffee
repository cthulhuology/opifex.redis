# Redis.coffee
#
#	© 2013 Dave Goehrig <dave@dloh.org>
#

redis = require 'redis'

Redis = () ->
	this.connect = (RedisUrl) =>
		[ host, port ] = (RedisUrl.match ///redis://([^:]+):(\d+)///)[1...]
		this.client = redis.createClient(port, host)
	this.set = (key, value) =>
		this.client?.set key, value, (err,value) =>
			this.send JSON.stringify([  err || "ok" , value ])
	this.get = (key) =>
		this.client?.get key, (err,value) =>
			this.send JSON.stringify([  err || "ok" , value ])

module.exports = Redis
