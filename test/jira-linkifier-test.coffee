chai  = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'jira-linkifier', ->

  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear:    sinon.spy()

    @prefixes = process.env.HUBOT_JIRA_LINKIFIER_PROJECT_PREFIXES = "XXX,YYY,ZZZ"
    @jiraUrl  = process.env.HUBOT_JIRA_LINKIFIER_JIRA_URL         = "https://foo.jira.com/browse"

    require('../src/jira-linkifier')(@robot)


  # TODO: figure out how to test the config here?

  # it "reads HUBOT_JIRA_LINKIFIER_JIRA_URL env variable for the base Jira URL", ->
  #   expect(@robot.jiraUrl).to.equal(@jiraUrl)

  # it "reads HUBOT_JIRA_LINKIFIER_PROJECT_PREFIXES env variable for a list of prefixes to match", ->
  #   expect(@robot.jiraUrl).to.equal(@prefixes)


  it "registers a hear to listener for matching patterns like '<prefix>-<numbers>'", ->
    ticketRegExp = new RegExp "(^|\\s+)(XXX|YYY|ZZZ)-[0-9]+($|\\s+)", "gi"
    expect(@robot.hear).to.have.been.calledWith(ticketRegExp)


  it "registers a respond listener for 'jl url", ->
    expect(@robot.respond).to.have.been.calledWith(/jl url/i)


  it "registers a respond listener for 'jl prefixes", ->
    expect(@robot.respond).to.have.been.calledWith(/jl prefixes/i)


