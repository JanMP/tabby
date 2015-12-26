Template.songEdit.helpers

  formId : ->
    id = FlowRouter.getParam "id"
    console.log(this._id, id)
    "songEdit-#{this.id}"

  song : ->
    id = FlowRouter.getParam "id"
    Songs.findOne id

  mayEdit : ->
    id = FlowRouter.getParam "id"
    song = Songs.findOne id
    song.userId is Meteor.userId()

  chords : ->
    Chords.find()

  tabs : ->
    Tabs.find
      songId : FlowRouter.getParam "id"
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
        songId : FlowRouter.getParam "id"
        chordId : event.data._id
        order : event.newIndex - 1
        beats : 4


Template.songTabDisplay.helpers

  chord : ->
    Chords.findOne(this.chordId)

  mayEdit : ->
    this.userId = Meteor.userId()

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

