Meteor.publish "chords", ->
  Chords.find()

Meteor.publish "songs", ->
  Songs.find()

Meteor.publish "songTabs", (songId) ->
  Tabs.find
    songId : songId