elastic = require './reporters/elastic'
Base = require '../mocha/lib/reporters/base'
{ElasticSearchError} = require './libs/errors'

@sessionId = null

send = (snippet, cb) =>
  @sessionId = snippet.sessionId if snippet.sessionId?
  snippet['sessionId'] = @sessionId
  elastic.send snippet, (e) ->
    return new ElasticSearchError e if e

reporter = (runner) ->
  self = @
  Base.call this, runner
  runner.on 'suite', (suite) ->
    if suite.file?
      send
        title: suite.title
        file: suite.file
        harness: 'loadTestContext'
        err: null

  runner.on 'pass', (test) ->
    send
      title: test.title
      duration: test.duration
      state: test.state
      harness: 'testStep'

  runner.on 'fail', (test, testErr) ->
    send
      title: test.title
      state: test.state
      harness: 'testStep'
      err: testErr.message.toString()

  runner.on 'end', ->
    send
      harness: 'testEnd'
      testCaseStart: self.stats.start
      testCaseEnd: self.stats.end
      testCaseDuration: self.stats.duration
      testCaseState: if self.stats.failures is 0 then 'passed' else 'failed'

module.exports = {
  reporter: reporter
  send: send
}