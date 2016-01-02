Metronome = () ->
  timer = ""
  
  urls = (name) -> ["/sounds/#{name}.ogg", "/sounds/#{name}.mp3", "/sounds/#{name}.aac", "/sounds/#{name}.wav"]
  snare = new Howl
    urls : urls "snare"
  bass = new Howl
    urls : urls "bass"

  doTimer = (bpb) ->
    beat = Session.get("beat") + 1
    Session.set "beat", beat
    if beat %% bpb is 1
      bass.play()
    else
      snare.play()
  start = (bpm, bpb=4) ->
    console.log "metronome start"
    console.log timer
    stop()
    timer = window.setInterval doTimer, 60/bpm*1000, bpb
    console.log timer
  stop = () ->
    console.log "metronome stop"
    console.log timer
    window.clearInterval timer
    Session.set "beat", 0
    console.log timer

  start : start
  stop : stop

@myMetronome = Metronome()