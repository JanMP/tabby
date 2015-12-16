Template.chords.helpers

  chords : -> Chords.find()

Template.displayChord.helpers

  formId : -> "editForm-#{this._id}"

Template.chords.events

  "click .new-chord-button" : ->
    Chords.insert newUkuleleChord()