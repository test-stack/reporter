elastic = require './reporters/elastic'
Base = require '../mocha/lib/reporters/base'
{ElasticSearchError} = require './libs/errors'

@sessionId = null
@runId = null
@tags = null

send = (snippet) =>
  snippet['sessionId'] = @sessionId = if !@sessionId? then snippet.sessionId else @sessionId
  snippet['runId'] = @runId = if !@runId? then Date.now()+Math.floor Math.random() * 10000 else @runId
  snippet['tags'] = @tags = if !@tags? then snippet.tags else @tags
  elastic.send snippet, (e) ->
    return new ElasticSearchError e if e

reporter = (runner) ->
  self = @
  Base.call this, runner
  testStepFailed = no
  runner.on 'suite', (suite) ->
    if suite.file? && !testStepFailed
      send
        title: suite.title
        file: suite.file
        harness: 'TestContext'
        err: null

  runner.on 'pass', (test) ->

    send
      title: test.title
      duration: test.duration
      state: test.state
      harness: 'Step'

  runner.on 'fail', (test, testErr) ->

    testStepFailed = yes
    send
      title: test.title
      duration: test.duration
      state: test.state
      harness: 'Step'
      err: testErr.message.toString()

  runner.on 'end', ->
    send
      harness: 'teardown'
      testCaseStart: self.stats.start
      testCaseEnd: self.stats.end
      testCaseDuration: self.stats.duration
      testCaseState: if self.stats.failures is 0 then 'passed' else 'failed'

module.exports = {
  reporter: reporter
  send: send
}
