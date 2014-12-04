Accounts.onCreateUser (options, user) ->
  accessToken = user.services.github.accessToken

  result = Meteor.http.get 'https://api.github.com/user',
    headers:
      'user-agent': 'Kraken'
    params:
      access_token: accessToken

  if result.error
    throw result.error

  console.log result.data
  user.profile = _.pick result.data,
    'login',
    'name',
    'avatar_url',
    'url'
    'company',
    'blog',
    'location',
    'email',
    'bio',
    'html_url'

  user
