Metronome = () ->
  
  timer = ""
  urls = (name) ->
    ["/sounds/#{name}.ogg", "/sounds/#{name}.mp3",
    "/sounds/#{name}.aac", "/sounds/#{name}.wav"]
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
    stop(bpb)
    timer = window.setInterval doTimer, 60/bpm*1000, bpb

  stop = (bpb) ->
    window.clearInterval timer
    Session.set "beat", -2*bpb

  start : start
  stop : stop

@myMetronome = Metronome()