SlackBot = require '../src/bot'

should = require 'should'


describe 'Adapter', ->
  it 'Should initialize with a robot', ->
    @slackbot.robot.should.eql @stubs.robot

describe 'Login', ->
  it 'Should set the robot name', ->
    @slackbot.robot.name.should.equal 'bot'

#describe 'Send Messages', ->
#  it 'Should send multiple messages', ->
#    sentMessages = @slackbot.send {room: 'general'}, 'one', 'two', 'three'
#    sentMessages.length.should.equal 3
#
#  it 'Should not send empty messages', ->
#    sentMessages = @slackbot.send {room: 'general'}, 'Hello', '', '', 'world!'
#    sentMessages.length.should.equal 2
#
#  it 'Should split long messages', ->
#    lines = 'Hello, Slackbot\nHow are you?\n'
#    # Make a very long message
#    msg = lines
#    len = 10000
#    msg += lines while msg.length < len
#
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.length.should.equal Math.ceil(len / SlackBot.MAX_MESSAGE_LENGTH)
#
#  it 'Should try to split on word breaks', ->
#    msg = 'Foo bar baz'
#    @slackbot.constructor.MAX_MESSAGE_LENGTH = 10
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.length.should.equal 2
#
#  it 'Should split into max length chunks if there are no breaks', ->
#    msg = 'Foobar'
#    @slackbot.constructor.MAX_MESSAGE_LENGTH = 3
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.should.eql ['Foo', 'bar']
#
#  it 'Should open a DM channel if needed', ->
#    msg = 'Test'
#    @slackbot.send {room: 'name'}, msg
#    @stubs._msg.should.eql 'Test'
#
#  it 'Should use an existing DM channel if possible', ->
#    msg = 'Test'
#    @slackbot.send {room: 'user2'}, msg
#    @stubs._dmmsg.should.eql 'Test'
#
#  it 'Should replace @name with <@U123> for mention', ->
#    msg = 'foo @name: bar'
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.should.equal 'foo <@U123>: bar'
#
#  it 'Should replace @name with <@U123> for mention (first word)', ->
#    msg = '@name: bar'
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.should.equal '<@U123>: bar'
#
#  it 'Should replace @name with <@U123> for mention (without colons)', ->
#    msg = 'foo @name bar'
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.should.equal 'foo <@U123> bar'
#
#  it 'Should replace @channel with <!channel> for mention', ->
#    msg = 'foo @channel: bar'
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.should.equal 'foo <!channel>: bar'
#
#  it 'Should replace multiple mentions with <!XXXX>', ->
#    msg = 'foo @everyone: @channel: bar'
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.should.equal 'foo <!everyone>: <!channel>: bar'
#
#  it 'Should replace multiple mentions with <!XXXX>/<@UXXXX>', ->
#    msg = 'foo @everyone: @name: bar'
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.should.equal 'foo <!everyone>: <@U123>: bar'
#
#  it 'Should not replace @name with <@U123> for mention when there is a typo', ->
#    msg = 'foo @naame: bar'
#    sentMessages = @slackbot.send {room: 'general'}, msg
#    sentMessage = sentMessages.pop()
#    sentMessage.should.equal 'foo @naame: bar'
