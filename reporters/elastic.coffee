elasticsearch = require 'elasticsearch'
elastic = new elasticsearch.Client
  host: process.config.ELASTICSEARCH

send = (snippet, cb) ->
  snippet['timestamp'] = new Date().toISOString()

  elastic.create
    index: 'testreport',
    type: 'testreport',
    body: snippet
  , cb

module.exports = {
  send: send
}
