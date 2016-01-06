getSong = ->
  Songs.findOne FlowRouter.getParam "id"

fetchTabs = ->
  tabs = Tabs.find(
    songId : FlowRouter.getParam "id"
  ,
    sort :
      order : 1
  ).fetch()
  startBeat = 1
  for tab in tabs
    tab.startBeat = startBeat
    startBeat += tab.beats
    tab.chord = Chords.findOne tab.chordId
  endBeat = startBeat

  tabs : tabs
  endBeat : endBeat

Template.songPlay.onCreated ->
  this.autorun =>
    id = FlowRouter.getParam "id"
    this.subscribe "songTabs", id

Template.songPlay.helpers

  song : -> getSong()
  beat : -> Session.get "beat"


Template.songPlay.events

  "click .start-button" : ->
    song = getSong()
    myMetronome.start song.bpm, song.beatsPerBar
    
  "click .stop-button" : ->
    song = getSong()
    myMetronome.stop song.beatsPerBar
    

Template.playTabDisplay.onCreated ->
 
  sameTab = (a, b) ->
    a?._id is b?._id

  this.tabData = new ReactiveVar fetchTabs()
  this.currentTab = new ReactiveVar {}, sameTab
  this.nextTab = new ReactiveVar {}, sameTab
  
  this.autorun =>
    beat = Session.get "beat"
    tabData = Template.instance().tabData.get()
    if tabData.tabs.length is 0
      tabData = fetchTabs()
    if 0 < beat < tabData.endBeat
      for tab, i in tabData.tabs
        if tab.startBeat <= beat < tab.startBeat + tab.beats
          current = i
    else
      if beat < 1
        current = 0
      else
        myMetronome.stop(getSong()?.beatsPerBar)

    Template.instance().currentTab.set tabData.tabs[current]
    Template.instance().nextTab.set tabData.tabs[current + 1]


Template.playTabDisplay.helpers

  currentChord : -> 
    currentTab = Template.instance().currentTab.get()
    currentTab?.chord

  currentLyrics : -> 
    currentTab = Template.instance().currentTab.get()
    currentTab?.lyrics

  nextChord : -> 
    nextTab = Template.instance().nextTab.get()
    nextTab?.chord

  nextLyrics : -> 
    nextTab = Template.instance().nextTab.get()
    nextTab?.lyrics

  beatFormatted : ->
    beat = Session.get "beat"
    beatsPerBar = getSong()?.beatsPerBar
    unless beat?
      ""
    if beat > 0
      "#{(beat - 1) // beatsPerBar + 1}:\
      #{(beat - 1) %% beatsPerBar + 1}"
    else
      "in #{1-beat}"
 
  countdown : ->
    beat = Session.get "beat"
    currentTab = Template.instance().currentTab.get()
    currentTab?.startBeat + currentTab?.beats - beat

