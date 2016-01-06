Template.songs.helpers

  songs : ->
    Songs.find {},
      sort :
        title : 1

Template.songDisplay.helpers
  
  mayEdit : ->
    this.userId is Meteor.userId()

Template.songs.events

  "click .new-song-button" : ->
    id = Songs.insert newSong()
    FlowRouter.go "/edit-song/#{id}"

Template.songEditButton.events

  "click .edit-button" : ->
    FlowRouter.go "/edit-song/#{this._id}"

Template.songDeleteButton.events

  "click .delete-button" : ->
    if confirm "really delete #{this._id}?"
      Meteor.call "removeSong", this._id

Template.songPlayButton.events

  "click .play-button" : ->
    FlowRouter.go "/play/#{this._id}"