#Testing shell

# 1. Create 3 users
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/users -d '{"user": {"email":"ctrengrove@hotmail.com", "name":"Clem Trengrove", "password":"clempassword"}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/users -d '{"user": {"email":"adamc@hotmail.com", "name":"Adam Cloud", "password":"adcdm123"}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/users -d '{"user": {"email":"ramano.test@gmail.com", "name":"Ramano Test", "password":"tdnjfveigoeh"}}'

# 2. Create 5 splatts for each user

#SPLATT 1
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Hello, Splater world", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Hello, Splater world, How are you?", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Third test splat for third user", "user_id":3}}'

#SPLATT 2
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Noone follows me, this sucks", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"I look like a stalker :( someone follow me!!", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Life is great", "user_id":3}}'

#SPLATT 3
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"This is boring", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"OMG user 1 posts such boring crap, like seriously", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Have to make heaps of photoshop mockups today.. great >:(", "user_id":3}}'

#SPLATT 4
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Sooo, noones talking to me still. Crap", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"My life sucks", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"How awesome are splatts yo!?", "user_id":3}}'

#SPLATT 5
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Reading through all my splatts.. Wow, Im a depressing dude!", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Haha user1 is such a loser lol", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Think Im gunna get twitter instead, this is crap", "user_id":3}}'

# 3. causes the first user to follow the other two
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/users/follows -d '{"id":1, "follows_id":2}'
curl -i -H "Content-type: application/json" -X POST http://trengrove.sqrawler.com:3000/users/follows -d '{"id":1, "follows_id":3}'

# 4. gets the first user's splatts
curl -i -H "Content-type: application/json" -X GET http://trengrove.sqrawler.com:3000/users/splatts/1 

# 5. gets the users followed by the first user
curl -i -H "Content-type: application/json" -X GET http://trengrove.sqrawler.com:3000/users/follows/1 

#6. gets the first users news feed
curl -i -H "Content-type: application/json" -X GET http://trengrove.sqrawler.com:3000/users/splatts-feed/1

#7. causes first user to unfollow third user
curl -i -H "Content-type: application/json" -X DELETE http://trengrove.sqrawler.com:3000/users/follows/1/3

#8. displays the first users news feed after unfollowing the third
curl -i -H "Content-type: application/json" -X GET http://trengrove.sqrawler.com:3000/users/splatts-feed/1