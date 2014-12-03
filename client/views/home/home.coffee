Template.home.events
  'submit': (event) ->
    event.preventDefault()

    organization = $('#org').val()
    repository = $('#repo').val()

    Meteor.call 'getOpenPullRequests', organization, repository, (error, response) ->
      if (!error)
        Meteor.call 'clearAlll'
        response.result.forEach (pullRequest) ->
          Meteor.call 'addPullRequest', pullRequest.title

Template.home.helpers
  pullRequests: ->
    PullRequests.find().fetch()
