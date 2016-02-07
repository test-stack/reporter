moment = require 'moment'
elasticsearch = require 'elasticsearch'
elastic = new elasticsearch.Client
  host: process.config.ELASTICSEARCH

send = (snippet, cb) ->
  snippet['timestamp'] = new Date().toISOString()

  elastic.create
    index: "testreport-#{moment().format 'YYYY.MM.DD'}",
    type: 'testreport',
    body: snippet
  , cb

module.exports = {
  send: send
}
