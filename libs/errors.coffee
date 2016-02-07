class ElasticSearchError extends Error
  constructor: (@message) ->
    @name = "ElasticSearchError"
    Error.captureStackTrace @, ElasticSearchError

module.exports = {
  ElasticSearchError
}
