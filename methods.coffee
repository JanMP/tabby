Meteor.methods

  removeSong : (songId) ->
    console.log "called"
    check songId, String
    song = Songs.findOne songId
    console.log this.userId, song.userId
    if this.userId is song.userId
      Songs.remove songId
      Tabs.remove
        songId : songId
    else
      throw new Meteor.Error "not authorized",
        "you can only remove your own songs"