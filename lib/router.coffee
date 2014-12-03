Router.configure
  layoutTemplate: 'layout'

beforeHooks =
  isLoggedIn: ->
    if !Meteor.userId()
      Router.go 'sign_in'
    @next()

Router.onBeforeAction beforeHooks.isLoggedIn,
  except: ['sign_in', 'sign_out']

Router.map ->

  @route 'home',
    path: '/'

  @route 'sign_in',
    path: 'sign_in'

  @route 'sign_out',
    path: 'sign_out'
    action: ->
      Meteor.logout()
      Router.go '/sign_in'
