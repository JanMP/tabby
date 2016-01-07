FlowRouter.route "/",
  action : ->
    BlazeLayout.render "layout",
      content : "about"

FlowRouter.route "/songs",
  action : ->
    BlazeLayout.render "layout",
      content : "songs"

FlowRouter.route "/edit-song/:id",
  action : ->
    BlazeLayout.render "layout",
    content : "songEdit"

FlowRouter.route "/play/:id",
  action : ->
    BlazeLayout.render "layout",
    content : "songPlay"

FlowRouter.route "/chords",
  action : ->
    BlazeLayout.render "layout",
      content : "chords"

FlowRouter.route "/settings",
  action : ->
    BlazeLayout.render "layout",
      content : "settings"

FlowRouter.route "/help",
  action : ->
    BlazeLayout.render "layout",
      content : "help"

FlowRouter.route "/user-admin",
  action : ->
    BlazeLayout.render "layout",
      content : "userAdmin"