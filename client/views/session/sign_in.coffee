Template.sign_in.created = ->
  Deps.autorun ->
    if Meteor.userId()
      Router.go 'home'
