Template.tabDisplay.onRendered ->

  this.autorun ->
  
    chord = Template.currentData().chord
    numStrings = chord.strings.length
    numFrets = chord.numFrets
     
    stringY = (string) ->
      numStrings = chord.strings.length
      (stage.getHeight() - 60) / (numStrings - 1) * string + 20
    
    fretX = (fret) ->
      numFrets = chord.numFrets
      (stage.getWidth() - 25) / numFrets * fret + 25
    
    fingerX = (fret) ->
      numFrets = chord.numFrets
      fretX(fret) + (stage.getWidth() - 25) / numFrets / 2
    
    stage = new Konva.Stage
      container : Template.currentData().displayId
      width : 200
      height : 200
    layer = new Konva.Layer()
    
    numStrings = chord.strings.length
    for name, i in chord.strings
      x = 5
      y = stringY i
      layer.add new Konva.Text
        x : x
        y : y - 10
        text : name
        fontSize : 20
        fill : "grey"
      layer.add new Konva.Line
        points : [25, y, stage.getWidth(), y]
        stroke : "black"
        strokeWidth : 1
    yTop = 20
    yBottom = stage.getHeight() - 40
    for i in [0..chord.numFrets]
      x = fretX i
      layer.add new Konva.Line
        points : [x, yTop, x, yBottom]
        stroke : "black"
        strokeWidth : 1
    for finger in chord.fingers
      x = fingerX finger.fret
      y = stringY finger.string
      unless finger.barre
        layer.add new Konva.Circle
          x : x
          y : y
          radius : 10
          fill : "pink"
      else
        layer.add new Konva.Line
          points : [x, y, x, stringY(0)]
          stroke : "pink"
          strokeWidth : 20
          lineCap : "round"
      fingerNumber = new Konva.Text
        x : x
        y : y
        text : finger.number
        fontSize : 14
      fingerNumber.setOffset
        x : fingerNumber.getWidth() / 2
        y : fingerNumber.getHeight() / 2
      layer.add fingerNumber
      for i in [0..numFrets - 1]
        fretNumber = new Konva.Text
          x : fingerX i
          y : stage.getHeight() - 20
          text : "#{i + chord.firstFret}"
          fontSize : 10
          fill : "grey"
        fretNumber.setOffset
          x : fingerNumber.getWidth() / 2
        layer.add fretNumber
    layer.draw()
    stage.add layer
  