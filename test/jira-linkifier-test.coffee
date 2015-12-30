chai  = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

path = require 'path'

Robot       = require("../node_modules/hubot/src/robot")
TextMessage = require("../node_modules/hubot/src/message").TextMessage


describe 'jira-linkifier', ->

  robot = null
  user = null
  adapter = null

  prefixes = process.env.HUBOT_JIRA_LINKIFIER_PROJECT_PREFIXES = "XXX,YYY,ZZZ"
  jiraUrl = process.env.HUBOT_JIRA_LINKIFIER_JIRA_URL = "https://foo.jira.com"

  expectedJiraBaseUrl = "https://foo.jira.com/browse/"

  # Create the adapter / robot just once
  before (done) ->
    # Create new robot, without http, using mock adapter
    robot = new Robot null, "mock-adapter", false

    robot.adapter.on "connected", ->

      # load the module under test and configure it for the
      # robot. This is in place of external-scripts
      require("../src/jira-linkifier")(robot)
      adapter = robot.adapter

      # create a user
      user = robot.brain.userForId("1", {
        name: "mocha",
        room: "#mocha"
      })

    robot.run()

    done()

  after ->
    robot.shutdown()

  afterEach ->
    robot.adapter.removeAllListeners()


  it 'responds with the URL when only the ticket name is in the message', (done) ->

    adapter.on "send", (envelope, strings) ->
      try
        expect( strings[0] ).to.equal("#{expectedJiraBaseUrl}XXX-1234")
        do done
      catch e
        done e

    adapter.receive(new TextMessage(user, 'XXX-1234'))


  it 'responds with the URL when only the ticket name is in the message', (done) ->

    adapter.on "send", (envelope, strings) ->
      try
        expect( strings[0] ).to.equal "#{expectedJiraBaseUrl}XXX-1234"
        expect( strings[1] ).to.equal "#{expectedJiraBaseUrl}YYY-4321"
        do done
      catch e
        done e

    adapter.receive(new TextMessage(user, 'XXX-1234 and this YYY-4321'))



  it 'responds with the URL when the ticket identifier starts the message', (done) ->

    adapter.on "send", (envelope, strings) ->
      try
        expect( strings[0] ).to.equal "#{expectedJiraBaseUrl}XXX-1234"
        do done
      catch e
        done e

    adapter.receive(new TextMessage(user, 'XXX-1234 foo bar'))


  it 'responds with the URL when the ticket identifier ends the message', (done) ->

    adapter.on "send", (envelope, strings) ->
      try
        expect( strings[0] ).to.equal "#{expectedJiraBaseUrl}XXX-1234"
        do done
      catch e
        done e

    adapter.receive(new TextMessage(user, 'foo bar XXX-1234'))


  it 'responds with the URL when the ticket identifier is between the beginning and end of the message', (done) ->

    adapter.on "send", (envelope, strings) ->
      try
        expect( strings[0] ).to.equal "#{expectedJiraBaseUrl}YYY-4321"
        do done
      catch e
        done e

    adapter.receive(new TextMessage(user, 'foo YYY-4321 bar'))


  it 'responds with the URL when the ticket identifier is between the beginning and end of the message', (done) ->

    adapter.on "send", (envelope, strings) ->
      try
        expect( strings[0] ).to.equal "#{expectedJiraBaseUrl}YYY-4321"
        do done
      catch e
        done e

    adapter.receive(new TextMessage(user, 'foo YYY-4321 bar'))








    # adapter.receive(new TextMessage(user, 'jl url'))
    # adapter.receive(new TextMessage(user, 'jl regex'))
    # adapter.receive(new TextMessage(user, 'jl prefixes'))
