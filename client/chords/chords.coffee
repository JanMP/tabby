Template.chords.helpers

  chords : -> Chords.find()


Template.editToggle.events

  "click .edit-toggle" : ->
    key = "editing-#{this._id}"
    Session.set key, not Session.get key

Template.deleteButton.events

  "click .delete-button" : ->
    if window.confirm "Do you really want to delete this chord?"
      Chords.remove this._id

Template.chordDisplay.helpers

  formId : -> "editForm-#{this._id}"

  displayId : -> "tabDisplay-#{this._id}"

  editing : ->
    key = "editing-#{this._id}"
    Session.get key

Template.chords.events

  "click .new-chord-button" : ->
    id = Chords.insert newUkuleleChord()
    key = "editing-#{id}"
    Session.set key, true