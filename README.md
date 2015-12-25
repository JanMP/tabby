# tabby
## a web-app for guitar and ukulele tabs

I am using Meteor with coffee-script, jade and stylus (to hell with curly brackets).

Very, very, very early development.

Try to run the latest development build [here](http://janmp-tabby.meteor.com) (meteor.com has quite frequent outages lately, so be patient)

under "chords" you can now create and edit tabs.
auto-form still got that bug handling arrays, so it screws up if you
delete any string or finger entry but the last.

User Access is built in on server side. That means you can only add new data
if you are logged in and you can only edit or delete data you have entered yourself. This is not reflected by the UI yet.

