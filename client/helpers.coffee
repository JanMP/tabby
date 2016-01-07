Template.registerHelper "loggedIn", ->
  if Meteor.user() then true else false

Template.registerHelper "isUserAdmin", ->
  Roles.userIsInRole Meteor.userId(), "userAdmin"