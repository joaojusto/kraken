beforeHooks =
  isLoggedIn: ->
    if !Meteor.userId()
      Router.go 'sign_in'
    @next()

Router.onBeforeAction beforeHooks.isLoggedIn,
  except: ['sign_in', 'sign_out']

Router.route '/home', ->
  this.render 'index'

Router.route '/sign_in', ->
  this.render 'sign_in'

Router.route '/sign_out', ->
  Meteor.logout()
  Router.go '/sign_in'
