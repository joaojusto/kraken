Template.header.helpers
  user: ->
    if Meteor.user()
      true
    else
      false

  profilePicture: ->
    Meteor.user().profile.avatar_url
