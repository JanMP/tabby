Template.tabDisplay.onRendered ->

  this.autorun ->
  
    chord = Template.currentData().chord
    numStrings = chord.strings.length
    numFrets = chord.numFrets
     
    size = $("##{Template.currentData().displayId}").width()

    stringY = (string) ->
      numStrings = chord.strings.length
      (stage.getHeight() - 0.3 * size) / (numStrings - 1) * string + size / 10
    
    fretX = (fret) ->
      numFrets = chord.numFrets
      (stage.getWidth() - size / 8) / numFrets * fret + size / 8
    
    fingerX = (fret) ->
      numFrets = chord.numFrets
      fretX(fret) + (stage.getWidth() - size / 8) / numFrets / 2
    
    stage = new Konva.Stage
      container : Template.currentData().displayId
      width : size
      height : size
    layer = new Konva.Layer()
    
    numStrings = chord.strings.length
    for name, i in chord.strings
      x = size / 40
      y = stringY i
      layer.add new Konva.Text
        x : x
        y : y - size / 20
        text : name
        fontSize : size / 10
        fill : "grey"
      layer.add new Konva.Line
        points : [size / 8, y, stage.getWidth(), y]
        stroke : "black"
        strokeWidth : 1
    yTop = size / 10
    yBottom = stage.getHeight() - size / 5
    for i in [0..chord.numFrets]
      x = fretX i
      layer.add new Konva.Line
        points : [x, yTop, x, yBottom]
        stroke : "black"
        strokeWidth :
          if chord.firstFret is 1 and i is 0 then 3 else 1
        lineCap : "round"
    for finger in chord.fingers
      x = fingerX finger.fret
      y = stringY finger.string
      unless finger.barre
        layer.add new Konva.Circle
          x : x
          y : y
          radius : size / 16
          fill : "pink"
      else
        layer.add new Konva.Line
          points : [x, y, x, stringY(0)]
          stroke : "pink"
          strokeWidth : size / 8
          lineCap : "round"
      fingerNumber = new Konva.Text
        x : x
        y : y
        text : finger.number
        fontSize : 0.08 * size
      fingerNumber.setOffset
        x : fingerNumber.getWidth() / 2
        y : fingerNumber.getHeight() / 2
      layer.add fingerNumber
      for i in [0..numFrets - 1]
        fretNumber = new Konva.Text
          x : fingerX i
          y : stage.getHeight() - size / 8
          text : "#{i + chord.firstFret}"
          fontSize : size / 16
          fill : "grey"
        fretNumber.setOffset
          x : fingerNumber.getWidth() / 2
        layer.add fretNumber
    layer.draw()
    stage.add layer
  