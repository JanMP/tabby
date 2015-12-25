Security.defineMethod "mayEdit",
  fetch : []
  transform : null
  deny : (type, arg, userId, doc) ->
    doc.userId isnt userId

Chords.permit(["insert"]).ifLoggedIn().apply()
Chords.permit(["update", "remove"]).ifLoggedIn().mayEdit().apply()
Songs.permit(["insert"]).ifLoggedIn().apply()
Songs.permit(["update", "remove"]).ifLoggedIn().mayEdit().apply()
Tabs.permit(["insert"]).ifLoggedIn().apply()
Tabs.permit(["update", "remove"]).ifLoggedIn().mayEdit().apply()