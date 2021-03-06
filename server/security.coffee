Security.defineMethod "mayEditData",
  fetch : []
  transform : null
  deny : (type, arg, userId, doc) ->
    doc.userId isnt userId and not Roles.userIsInRole userId, ["dataAdmin"]

Chords.permit(["insert"]).ifLoggedIn().apply()
Chords.permit(["update", "remove"]).ifLoggedIn().mayEditData().apply()
Songs.permit(["insert"]).ifLoggedIn().apply()
Songs.permit(["update", "remove"]).ifLoggedIn().mayEditData().apply()
Tabs.permit(["insert"]).ifLoggedIn().apply()
Tabs.permit(["update", "remove"]).ifLoggedIn().mayEditData().apply()
Meteor.users.permit(["update", "remove"]).ifLoggedIn()
.ifHasRole("userAdmin").apply()