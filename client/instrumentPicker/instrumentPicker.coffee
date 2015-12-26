Template.instrumentPicker.onCreated ->
  Session.setDefault "instrument", "guitar"

Template.instrumentPicker.helpers

  selected : (instrument) ->
    Session.equals "instrument", instrument

Template.instrumentPicker.events

  "change #instrument-picker" : (event) ->
    Session.set "instrument", $(event.target).val()