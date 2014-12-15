GitHubAPI = Meteor.npmRequire('github')

github = new GitHubAPI
  debug: true,
  timeout: 5000,
  version: '3.0.0',
  protocol: 'https',
  pathPrefix: '/api/v3',
  headers:
    'user-agent': 'Kraken'

githubAccessToken = ->
  Meteor.user().services.github.accessToken

Meteor.methods
  'getOpenPullRequests': (organization, repository) ->
    pullRequests = Async.runSync (done) ->
      github.pullRequests.getAll
        user: organization,
        repo: repository
      , (error, response) ->
        done(null, response)
    return pullRequests

  'getUserProfile': ->
    accessToken = githubAccessToken()

    result = Meteor.http.get 'https://api.github.com/user',
      headers:
        'user-agent': 'Kraken'
      params:
        access_token: accessToken

    if result.error
      throw result.error
    else
      result.data

  'getUserRepositories': ->
    accessToken = githubAccessToken()

    result = Meteor.http.get 'https://api.github.com/users/' + Meteor.user().profile.login + '/repos',
      headers:
        'user-agent': 'Kraken'
      params:
        access_token: accessToken

    if result.error
      throw result.error
    else
      console.log result.data
      result.data
