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

  it "reads HUBOT_JIRA_LINKIFIER_JIRA_URL env variable for the base JIRA URL", ->
    expect(process.env.HUBOT_JIRA_LINKIFIER_JIRA_URL).to.equal(@jiraUrl)

  it "reads HUBOT_JIRA_LINKIFIER_PROJECT_PREFIXES env variable for a list of prefixes to match", ->
    expect(process.env.HUBOT_JIRA_LINKIFIER_PROJECT_PREFIXES).to.equal(@prefixes)


  it "registers a hear to listener for matching patterns like '<prefix>-<numbers>'", ->
    ticketRegExp = new RegExp "(^|\\s+)(XXX|YYY|ZZZ)-[0-9]+($|\\s+)", "gi"
    expect(@robot.hear).to.have.been.calledWith(ticketRegExp)


  it "registers a respond listener for 'jl url", ->
    expect(@robot.respond).to.have.been.calledWith(/jl url/i)


  it "registers a respond listener for 'jl prefixes", ->
    expect(@robot.respond).to.have.been.calledWith(/jl prefixes/i)
