# Description
#   Hubot listens for a list of your JIRA project codes and responds with full clickable links to the tickets.
#
# Configuration:
#  HUBOT_JIRA_LINKIFIER_PROJECT_CODES 
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Chris Coveney <xkickflip@gmail.com>

module.exports = (robot) ->
  robot.respond /hello/, (res) ->
    res.reply "hello!"

  robot.hear /orly/, ->
    res.send "yarly"


