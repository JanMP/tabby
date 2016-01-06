Template.chords.helpers

  chords : -> Chords.find
    instrument : Session.get "instrument"


Template.chordEditToggle.events

  "click .edit-toggle" : ->
    key = "editing-#{this._id}"
    Session.set key, not Session.get key

Template.chordDeleteButton.events

  "click .delete-button" : ->
    if window.confirm "Do you really want to delete this chord?"
      Chords.remove this._id


Template.chordDisplay.helpers

  editing : ->
    key = "editing-#{this._id}"
    Session.get key

  formId : ->
    "form-#{this._id}"

  mayEdit : ->
    this.userId is Meteor.userId()

  string : ->
    Session.get("chord-#{this._id}-position")?.string

  fret : ->
    Session.get("chord-#{this._id}-position")?.fret


setFinger = (fingerNumber, tmplInst) ->
  
  fingerAtPosition = (finger) ->
    finger.fret is position.fret and finger.string is position.string

  sameFinger = (finger) ->
    finger.number is fingerNumber

  id = tmplInst.data._id
  position = Session.get "chord-#{id}-position"
  if position?
    fingers = tmplInst.data.fingers
    finger = _(fingers).find fingerAtPosition
    finger ?=
      number : 1
      fret : position.fret
      string : position.string
      barre : false
    if fingerNumber is 0
      finger.barre = not finger.barre
    if fingerNumber > 0
      finger.number = fingerNumber
    newFingers = _.chain(fingers).reject(fingerAtPosition).reject(sameFinger).value()
    if fingerNumber >= 0
      newFingers.push finger
    Chords.update id,
      $set :
        fingers : newFingers


Template.chordDisplay.events

  "click .one-button" : (event, tmplInst) -> setFinger 1, tmplInst
  "click .two-button" : (event, tmplInst) -> setFinger 2, tmplInst
  "click .three-button" : (event, tmplInst) -> setFinger 3, tmplInst
  "click .four-button" : (event, tmplInst) -> setFinger 4, tmplInst
  "click .five-button" : (event, tmplInst) -> setFinger 5, tmplInst
  "click .barre-button" : (event, tmplInst) -> setFinger 0, tmplInst
  "click .delete-button" : (event, tmplInst) -> setFinger -1, tmplInst


Template.chords.events

  "click .new-chord-button" : ->
    id = Chords.insert switch Session.get "instrument"
      when "guitar" then newGuitarChord()
      else newUkuleleChord()
    key = "editing-#{id}"
    Session.set key, true