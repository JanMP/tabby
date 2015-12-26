Template.registerHelper "loggedIn", ->
  if Meteor.user() then true else false