Accounts.onCreateUser (options, user) ->
  result = Meteor.call('getUserProfile')
  console.log result
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
