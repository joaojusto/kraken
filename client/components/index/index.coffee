Template.index.events
  'submit': (event) ->
    event.preventDefault()

    organization = $('#org').val()
    repository = $('#repo').val()

    Meteor.call 'getOpenPullRequests', organization, repository, (error, response) ->
      if (!error)
        Meteor.call 'clearAlll'
        response.result.forEach (pullRequest) ->
          Meteor.call 'addPullRequest', pullRequest.title

Template.index.helpers
  pullRequests: ->
    PullRequests.find().fetch()
