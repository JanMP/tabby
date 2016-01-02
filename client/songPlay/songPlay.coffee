getSong = () ->
  Songs.findOne FlowRouter.getParam "id"
  

Template.songPlay.helpers

  song : -> getSong()

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
    song = getSong()
    myMetronome.start song.bpm, song.beatsPerBar
    
  "click .stop-button" : ->
    myMetronome.stop()
    


Template.playTabDisplay.helpers

  chord : ->
    Chords.findOne this.chordId

  
  beatHelper : ->
    song = getSong()
    nextTab = Tabs.findOne
      songId : FlowRouter.getParam "id"
      order :
        $gt : this.order
    ,
      sort :
        order : 1
    nextChord = Chords.findOne nextTab?.chordId
    startBeat = 1
    cursor = Tabs.find
      songId : FlowRouter.getParam "id"
      order :
        $lt : this.order
    cursor.forEach (tab) ->
      startBeat += tab.beats
    beat = Session.get "beat"
    
    beatFormatted : "#{(beat - 1) // song.beatsPerBar + 1}:#{(beat - 1) %% song.beatsPerBar + 1}"
    active : startBeat <= beat < startBeat + this.beats
    countdown : startBeat + this.beats - beat
    nextTab : nextTab
    nextChord : nextChord
    
