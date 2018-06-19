h = require 'react-hyperscript'

alert = (message, klass='primary')=>
  h ".alert",
    className: "alert-#{klass}"
    role: "alert"
  , message

alert_dismisible = (message, klass='primary', dissmiss=false)=>
  h ".alert",
    className: "alert-#{klass}#{if dissmiss then ' alert-dismissible fade' else ''}"
    role: "alert"
  , message

alert_link = (message, url="#")=>
  h 'a.alert-link',
    href: url
  , message

module.exports =
  alert: alert
  alert_dismisible: alert_dismisible
  alert_link: alert_link



