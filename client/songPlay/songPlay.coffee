Template.songPlay.onCreated ->
  this.autorun ->
    beatTimer.tick()
    startTime = Session.get "startTime"
    bpm = Session.get "bpm"
    beat = Math.round((new Date() - startTime)/(60000/bpm))
    Session.set "beat", beat


Template.songPlay.helpers

  song : ->
    id = FlowRouter.getParam "id"
    Songs.findOne id

  tabs : ->
    id = FlowRouter.getParam "id"
    result = Tabs.find
      songId : id
    ,
      sort :
        order : 1
    result

  beat : -> Session.get "beat"

Template.songPlay.events

  "click .start-button" : ->
    console.log "start"
    Session.set "startTime", new Date()
    Session.set "bpm", 60
    beatTimer.start(60/Session.get "bpm")

  "click .stop-button" : ->
    console.log "stop"
    beatTimer.stop()
    


Template.playTabDisplay.helpers

  chord : ->
    Chords.findOne this.chordId

  nextTab : ->
    Tabs.findOne
      songId : FlowRouter.getParam "id"
      order :
        $gt : this.order
    ,
      sort :
        order : 1

  beatHelper : ->
    startBeat = 1
    cursor = Tabs.find
      songId : FlowRouter.getParam "id"
      order :
        $lt : this.order
    cursor.forEach (tab) ->
      startBeat += tab.beats
    beat = Session.get "beat"
    active : startBeat <= beat < startBeat + this.beats
    countdown : startBeat - beat
