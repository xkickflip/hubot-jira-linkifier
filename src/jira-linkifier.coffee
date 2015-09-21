# Description
#   Hubot listens for a list of your JIRA project codes and responds with full clickable links to the tickets.
#
# Configuration:
#  HUBOT_JIRA_LINKIFIER_JIRA_URL
#  HUBOT_JIRA_LINKIFIER_PROJECT_PREFIXES
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

  # ENV variable for list of project prefixes
  prefixes = process.env.HUBOT_JIRA_LINKIFIER_PROJECT_PREFIXES?.split(',') || []

  # Base URL for your JIRA install.  Strip trailing slash if it's included
  jiraUrl = process.env.HUBOT_JIRA_LINKIFIER_JIRA_URL || ""

  # Strip leading & trailing whitespace & trailing /
  jiraUrl = jiraUrl.replace /^\s+|\s+$|\/\s*$/g, ""



  # insensitive match all occurences of ticket tags like "FOO-2345" accounting for it occuring at
  # the beginning of the string or separated from the string by whitespace on both sides
  #
  # TODO: the capture groups with the global match are always returning the spaces with the matches
  # not sure how to split that out in the .match so for now I'm trimming the matches in the .hear block below
  ticketRegExp = new RegExp "(^|\\s+)(#{prefixes.join('|')})-[0-9]+($|\\s+)", "gi"

  # Print full ticket URLs for all matched prefix + number occurences in a message
  robot.hear ticketRegExp, (res) ->
    for ticketMatch in res.match
      res.send "#{jiraUrl}/browse/#{ticketMatch.trim().toUpperCase()}"



  # TODO: debug print the generated regex, remove me
  robot.hear /jira regexp/i, (res) ->
    res.send regexp



  # "jira prefixes": print out all current prefixes that will be matched
  robot.hear /jira prefixes/i, (res) ->
    for prefix in prefixes
      res.send prefix

  # TODO: add prefix
  # TOOD: delete prefix



  # TODO: store prefixes in robot.brain
  # if the brain has prefixes then don't load the ENV variables anymore


  # TODO: if  the hubot admin extension is installed don't allow modifying prefixes
  # unless the user has the "jira-linkifier-admin" role or something