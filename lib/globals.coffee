@Chords = new Mongo.Collection "chords"

fingerSchema = new SimpleSchema
  number :
    type : Number #the finger number displayed in the tab
  fret :
    type : Number #the fret in [0..numFrets]
  string :
    type : Number #the index of the string
  barre :
    type : Boolean #barre to this string starting at string 0

tabSchema = new SimpleSchema
  instrument :
    type : String
  name :
    type : String #name of the chord
  strings :
    type : [String] #names of the strings
  numFrets :
    type : Number #number of frets displayed in the tab
  firstFret :
    type : Number #the leftmost fret displayed in the tab
  fingers :
    type : [fingerSchema]

Chords.attachSchema tabSchema

@newUkuleleChord = ->
  instrument : "ukulele-hawaii"
  name : "new Chord"
  strings : ["A", "E", "C", "G"]
  numFrets : 4
  firstFret : 1
  fingers : [
    number : 1
    fret : 0
    string : 3
    barre : true
  ,
    number : 2
    fret : 1
    string : 0
    barre : false
  ,
    number : 3
    fret : 2
    string : 1
    barre : false
  ,
    number : 4
    fret : 3
    string : 2
    barre : false
  ]