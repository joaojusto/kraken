Meteor.startup ->
  console.log 'start'
  UserLoginState.onLogout ->
    console.log 'login'
    console.log Meteor.user()
    console.log Meteor.call 'getUserProfile'
