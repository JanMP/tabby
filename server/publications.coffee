Meteor.publish "chords", ->
  Chords.find()

Meteor.publish "songs", ->
  Songs.find()

Meteor.publish "roles", ->
  Meteor.roles.find()

Meteor.publish "songTabs", (songId) ->
  Tabs.find
    songId : songId

Meteor.publish "userAdmin", ->
  if Roles.userIsInRole this.userId, "userAdmin"
    Meteor.users.find()