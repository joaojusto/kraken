GitHubAPI = Meteor.npmRequire('github')

github = new GitHubAPI
  debug: true,
  timeout: 5000,
  version: '3.0.0',
  protocol: 'https',
  pathPrefix: '/api/v3',
  headers:
    'user-agent': 'Kraken'

Meteor.methods
  'getOpenPullRequests': (organization, repository) ->
    pullRequests = Async.runSync (done) ->
      github.pullRequests.getAll
        user: organization,
        repo: repository
      , (error, response) ->
        done(null, response)
    return pullRequests
