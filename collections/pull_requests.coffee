@PullRequests = new Mongo.Collection 'pullRequests'

Meteor.methods
  'clearAlll': ->
    PullRequests.remove({})
  ,

  'addPullRequest': (title) ->
    PullRequests.insert
      title: title
