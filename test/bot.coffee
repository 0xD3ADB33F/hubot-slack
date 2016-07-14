should = require 'should'

describe 'Adapter', ->
  it 'Should initialize with a robot', ->
    @slackbot.robot.should.eql @stubs.robot

describe 'Login', ->
  it 'Should set the robot name', ->
    @slackbot.robot.name.should.equal 'bot'

describe 'Logger', ->
  it 'It should log missing token error', ->
    {logger} = @slackbot.robot
    @slackbot.options.token = null
    @slackbot.run()
    logger.logs["error"].length.should.be.above(0)
    logger.logs["error"][logger.logs["error"].length-1].should.equal 'No service token provided to Hubot'

  it 'It should log invalid token error', ->
    {logger} = @slackbot.robot
    @slackbot.options.token = "ABC123"
    @slackbot.run() -
    logger.logs["error"].length.should.be.above(0)
    logger.logs["error"][logger.logs["error"].length-1].should.equal 'Invalid service token provided, please follow the upgrade instructions'

describe 'Send Messages', ->
  it 'Should send a message', ->
    sentMessages = @slackbot.send {room: 'general'}, 'message'
    sentMessages.length.should.equal 1
    sentMessages[0].should.equal 'message'

  it 'Should send multiple messages', ->
    sentMessages = @slackbot.send {room: 'general'}, 'one', 'two', 'three'
    sentMessages.length.should.equal 3

  it 'Should not send empty messages', ->
    sentMessages = @slackbot.send {room: 'general'}, 'Hello', '', '', 'world!'
    sentMessages.length.should.equal 2

  it 'Should open a DM channel if needed', ->
    msg = 'Test'
    @slackbot.send {room: 'name'}, msg
    @stubs._msg.should.eql 'Test'

  it 'Should use an existing DM channel if possible', ->
    msg = 'Test'
    @slackbot.send {room: 'user2'}, msg
    @stubs._dmmsg.should.eql 'Test'

describe 'Reply to Messages', ->
  it 'Should mention the user in a reply sent in a channel', ->
    sentMessages = @slackbot.reply {user: @stubs.user, room: @stubs.channel.id}, 'message'
    sentMessages.length.should.equal 1
    sentMessages[0].should.equal "<@#{@stubs.user.id}>: message"

  it 'Should mention the user in multiple replies sent in a channel', ->
    sentMessages = @slackbot.reply {user: @stubs.user, room: @stubs.channel.id}, 'one', 'two', 'three'
    sentMessages.length.should.equal 3
    sentMessages[0].should.equal "<@#{@stubs.user.id}>: one"
    sentMessages[1].should.equal "<@#{@stubs.user.id}>: two"
    sentMessages[2].should.equal "<@#{@stubs.user.id}>: three"

  it 'Should send nothing if messages are empty', ->
    sentMessages = @slackbot.reply {user: @stubs.user, room: @stubs.channel.id}, ''
    sentMessages.length.should.equal 0

  it 'Should NOT mention the user in a reply sent in a DM', ->
    sentMessages = @slackbot.reply {user: @stubs.user, room: 'D123'}, 'message'
    sentMessages.length.should.equal 1
    sentMessages[0].should.equal "message"