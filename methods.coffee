Meteor.methods

  removeSong : (songId) ->
    check songId, String
    song = Songs.findOne songId
    if this.userId is song.userId or Roles.userIsInRole this.userId, "dataAdmin"
      Songs.remove songId
      Tabs.remove
        songId : songId
    else
      throw new Meteor.Error "not authorized",
        "you can only remove your own songs"

  deleteUser : (userId) ->
    unless Roles.userIsInRole this.userId, "userAdmin"
      throw new Meteor.Error "not authorized",
        "you must be an userAdmin to do this"
    check userId, String
    keeperId = Meteor.users.findOne({username:"keeper"})._id
    if keeperId?

      Songs.update {userId : userId}, {$set:{userId : keeperId}}, {multi : true}
      Chords.update {userId : userId}, {$set:{userId : keeperId}}, {multi : true}
      Tabs.update {userId : userId}, {$set:{userId : keeperId}}, {multi : true}
    Meteor.users.remove userId
   