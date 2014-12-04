Template.header.helpers
  profilePicture: ->
    Meteor.user().profile.avatar_url
