h = require 'react-hyperscript'
React = require 'react'

class EmailLogin extends React.Component
  constructor: ->
    super()
    @state =
      email: ''
      password: ''
      error: false
  onEmailChange: (value)=>
    @setState
      email: value
  onPasswordChange: (value)=>
    @setState
      password: value
  onSubmit: (e)=>
    e.preventDefault()
    @props.submit @state.email, @state.password, (err)=>
      if err 
        @setState error: err
      else 
        @setState error: false
  render: ()=>
    h 'form.form-horizontal', [
      h require('../parts/input/form_input_email'), onChange: @onEmailChange
      h require('../parts/input/form_input_password'), onChange: @onPasswordChange
      h '.form-group.row', [
        h '.col-sm-9.offset-sm-3', [
          h 'button.btn.btn-block.btn-primary',
            type: 'submit'
            onClick: @onSubmit
          , 'Sign in'
        ]
        if @state.error 
          h '.col-sm-12', [
            h '.alert.alert-danger', @state.error
          ]
      ]
    ]

module.exports = EmailLogin
