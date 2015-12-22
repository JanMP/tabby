Template.songEdit.helpers

  formId : ->
    id = FlowRouter.getParam "id"
    console.log(this._id, id)
    "songEdit-#{this.id}"

  song : ->
    id = FlowRouter.getParam "id"
    Songs.findOne id

  chords : ->
    Chords.find()

  tabs : ->
    Tabs.find
      song : FlowRouter.getParam "id"
    ,
      sort :
        order : 1

  chordSortableOptions : ->
    sort : false
    draggable : ".draggable-chord"
    group :
      name : "chords"
      put : false
      pull : "clone"
    animation : 200
    ghostClass : "ghost"

  tabSortableOptions : ->
    sort :
      order : 1
    sortField : "order"
    draggable : ".draggable-tab"
    group :
      name : "tabs"
      put : ["chords", "tabs"]
      pull : true
    animation : 200
    ghostClass : "ghost"
    onAdd : (event, templInst) ->
      itemEl = event.item
      itemEl.parentElement.removeChild(itemEl)
      console.log event.newIndex
      templInst.collection.insert
        song : FlowRouter.getParam "id"
        chord : event.data._id
        order : event.newIndex - 1
        beats : 4
        lyrics : "lalala"


Template.songTabDisplay.helpers

  chord : ->
    Chords.findOne(this.chord)

  displayId : -> "tab-display-#{this._id}"

  lyricsFieldOptions : ->
    collection : "tabs"
    field : "lyrics"
    acceptEmpty : true
    textarea : true
    placeholder : "add lyrics"
    substitute : "add lyrics"


Template.songTabDisplay.events

  "click .delete-button" : ->
    Tabs.remove this._id

