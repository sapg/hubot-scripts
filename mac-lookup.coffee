# Description:
#  Lookup the vendor for a given MAC address
#
# Commands:
#
# hubot mac <MAC address>
#
#
# Configuration:
#
# HUBOT_MAC_LOOKUP_API_KEY - API key from www.macvendorlookup.com
#
#
# Author:
#  Sapan Ganguly (with help from Stanley Stuart and Alex Kocharin over at nodejs@googlegroups.com)

macvendorApiKey  = process.env.HUBOT_MAC_LOOKUP_API_KEY

module.exports = (robot) ->
  robot.respond /mac (.*)/i, (msg) ->
    mac = escape(msg.match[1])
    console.log msg.match
    msg.http("http://www.macvendorlookup.com/api/#{macvendorApiKey}/#{mac}")
      .get() (err, res, body) ->
        try
         json = JSON.parse(body)
         msg.send "#{require('util').inspect(json[0])}"
        catch error
          msg.send "Er, couldn't find the vendor for that MAC"
