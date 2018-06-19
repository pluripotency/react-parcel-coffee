h = require 'react-hyperscript'
React = require 'react'
alerts = require './alert'

klass = require '../klass_module'
klasses = klass.klasses
klass_obj = klass.klass_obj

class AlertsExample extends React.Component
  constructor: ()->
    super(arguments...)
    @state =
      alert_dismiss: false

  render: ()=>
    h '.row', [
      h '.col-sm-6', [
        h 'div', klasses.map (klass)=>
          alerts.alert "this is #{klass}", klass
      ]
      h '.col-sm-6', [
        alerts.alert [
          "this is  a #{klass_obj.primary} alert with "
          alerts.alert_link 'an example link', '#'
          ". Give it a click if you like."
        ], klass_obj.primary
        alerts.alert [
          h 'h4.alert-heading', "Well done!"
          h 'p', "This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of contents"
          h 'hr'
          h 'p.mb-0', 'Whenever you need to, be suer to use margin utilities to keep things nice and tidy.'
        ], klass_obj.success
        alerts.alert_dismisible [
          h 'strong', "Holy guacamole!"
          'You should check in on some of those fields below.'
          h 'button.close',
            onClick: (e)=>
              e.preventDefault()
              @setState alert_dismiss: true
          , [
            h 'span', 'x'
          ]
        ], klass_obj.warning, @state.alert_dismiss
        h 'label.btn.btn-primary',
          className: "#{unless @state.alert_dismiss then 'disabled' else ''}"
          onClick: ()=>
            @setState alert_dismiss: false
        , 'show alert again'
      ]
    ]

module.exports = AlertsExample
    
    
    