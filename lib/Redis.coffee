# Redis.coffee
#
#	© 2013 Dave Goehrig <dave@dloh.org>
#

Opifex = require 'opifex'
redis = require 'redis'

Redis = (SrcAmqpUrl, RedisUrl, DstExchange) ->
	[ host, port ] = (RedisUrl.match ///redis://([^:]+):(\d+)///)[1...]
	client = redis.createClient(port, host)
	response = (key) ->
		(err,value) ->
			if err
				opi.send DstExhange, "#{key}.error", JSON.stringify([ "error", err ])
			else
				opi.send DstExchange, "#{key}.ok", JSON.stringify([ "ok", value ])
	opi = Opifex(SrcAmqpUrl)
	opi.set = (key, value) ->
		client.set key, value, response("#{this.key}.set")
	opi.get = (key) ->
		client.get key, response("#{this.key}.get")

module.exports = Redis
