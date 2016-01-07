Template.userAdmin.onCreated ->
  this.subscribe "userAdmin"
  this.subscribe "roles"


Template.userAdmin.helpers

  users : ->
    Meteor.users.find()


Template.adminDisplayUser.helpers

  allRoles : ->
    roles = Roles.getAllRoles().fetch()
    userId = Template.currentData()._id
    for role in roles
      role.roleClass = if Roles.userIsInRole userId, role.name
        "isInRole"
      else
        "isNotInRole"
    roles


Template.adminDisplayUser.events

  "click .isInRole" :  (event, tmplInst) ->
    rolename = this.name
    username = tmplInst.data.username
    userId = tmplInst.data._id
    unless username is "admin" or username is Meteor.user().username
      Roles.removeUsersFromRoles userId, rolename

  "click .isNotInRole" : (event, tmplInst) ->
    rolename = this.name
    username = tmplInst.data.username
    userId = tmplInst.data._id
    unless username is "admin" or username is Meteor.user().username
      Roles.addUsersToRoles userId, rolename
    