@Chords = new Mongo.Collection "chords"

@fingerSchema = new SimpleSchema
  number :
    type : Number #the finger number displayed in the tab
  fret :
    type : Number #the fret in [0..numFrets]
  string :
    type : Number #the index of the string
  barre :
    type : Boolean #barre to this string starting at string 0

@chordSchema = new SimpleSchema
  instrument :
    type : String
    autoform :
      type : "hidden"
  name :
    type : String #name of the chord
  userId :
    type : String
    autoValue : ->
      unless this.isSet
        Meteor.userId()
    autoform :
      type : "hidden"
  strings :
    type : [String] #names of the strings
    autoform :
      type : "hidden"
  numFrets :
    type : Number #number of frets displayed in the tab
  firstFret :
    type : Number #the leftmost fret displayed in the tab
  fingers :
    type : [fingerSchema]

Chords.attachSchema chordSchema

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

@newGuitarChord = ->
  instrument : "guitar"
  name : "new Chord"
  strings : ["E", "B", "G", "D", "A", "E"]
  numFrets : 4
  firstFret : 1
  fingers : [
    number : 1
    fret : 0
    string : 5
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

@Songs = new Mongo.Collection "songs"

@songSchema = new SimpleSchema
  title :
    type : String
  userId :
    type : String
    autoValue : ->
      unless this.isSet
        Meteor.userId()
    autoform :
      type : "hidden"
  beatsPerBar :
    type : Number
  bpm :
    type : Number

Songs.attachSchema songSchema

@newSong = ->
  title : "Song Title"
  beatsPerBar : 4
  bpm : 90

@Tabs = new Mongo.Collection "tabs"

@tabSchema =  new SimpleSchema
  songId :
    type : String #the _id of the Song
  userId :
    type : String
    autoValue : ->
      unless this.isSet
        Meteor.userId()
  chordId :
    type : String #the _id of the Chord
  order :
    type : Number #the ordinal from Rubaxa-Sortable
  beats :
    type : Number
  lyrics :
    type : String
    optional : true

Tabs.attachSchema tabSchema

@newTab = (songId, chordId) ->
  songId : songId
  chordId : chordId
  order : 1000
  beats : 4
  


