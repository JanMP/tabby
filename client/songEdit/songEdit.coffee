Template.songEdit.onCreated ->
  this.autorun =>
    id = FlowRouter.getParam "id"
    this.subscribe "songTabs", id


Template.songEdit.helpers

  formId : ->
    id = FlowRouter.getParam "id"
    "songEdit-#{id}"

  song : ->
    id = FlowRouter.getParam "id"
    Songs.findOne id

  mayEdit : ->
    id = FlowRouter.getParam "id"
    song = Songs.findOne id
    song?.userId is Meteor.userId() or
      Roles.userIsInRole Meteor.userId(), "dataAdmin"

  chords : ->
    Chords.find
      instrument : Session.get "instrument"

  tabs : ->
    Tabs.find
      songId : FlowRouter.getParam "id"
    ,
      sort :
        order : 1

  chordSortableOptions : ->
    sort : false
    draggable : ".draggable"
    group :
      name : "chords"
      put : ["chords"]
      pull : "clone"
    animation : 200
    ghostClass : "ghost"
    onRemove : (event, templInst) ->
  tabSortableOptions : ->
    sort : true
    sortField : "order"
    draggable : ".draggable"
    group :
      name : "tabs"
      put : ["chords", "tabs"]
      pull : true
    animation : 200
    ghostClass : "ghost"
    onAdd : (event, templInst) ->
      #since we can't rely on event.newIndex:
      index =  if event.item.nextElementSibling?
        Blaze.getData(event.item.nextElementSibling).order - 0.5
      else if event.item.previousElementSibling?
        Blaze.getData(event.item.previousElementSibling).order + 0.5
      else 0
      #clean up behind Sortable
      event.clone.style.display = "none"
      event.from.insertBefore event.item, event.clone

      templInst.collection.insert
        songId : FlowRouter.getParam "id"
        userId : Meteor.userId()
        chordId : event.data._id
        order : index
        beats : 4

Template.songTabDisplay.helpers

  chord : ->
    Chords.findOne(this.chordId)

  mayEdit : ->
    this.userId is Meteor.userId()

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

  "click .plus-button" : ->
    Tabs.update this._id,
      $inc :
        beats : 1

  "click .minus-button" : ->
    Tabs.update this._id,
      $inc :
        beats : -1
