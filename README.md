opifex.redis
============

An AMQP -> Redis worker that keeps AMQP and Redis in sync

Usage
-----

	OpiRedis = require 'opifex.redis'
	opi = OpiRedis 'amqp://user:password@host:port/domain/exchange/queue/key', 'redis://localhost:6379', 'destination'

Opifex.redis will listen to the given amqp exchange / queue / routing key and perform queries against the given redis node.
The results of the queries will then be sent to the destination exchange on the same amqp server.  The routing key provided
by the sender will be used as a prefix to the routing key for the destination.



