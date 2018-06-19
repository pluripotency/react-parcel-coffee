h = require 'react-hyperscript'
React = require 'react'

card = require '../parts/components/card'
Modal = require '../parts/modal'

form_email_login = require './email_login'

mock_login_submit = (email, password, cb)=>
  if email == 'a@bc.local' and password == 'password'
    cb null
  else
    cb 'Invalid email or password'

class ModalLoginForm extends React.Component
  constructor: ->
    super()
    @state = open: false
  render: =>
    if @state.open
      h Modal,
        modal_size: ''
        title: 'Login Modal'
        body: [
          h form_email_login,
            submit: mock_login_submit
        ]
        close_func: ()=> @setState open:false
    else
      h 'label.btn.btn-primary',
        onClick: ()=> @setState open: true
      , 'Modal Login'

module.exports = ()=>
    h 'div', [
      h 'h3', 'Login Forms'
      h '.row', [
        h '.col-sm-6', [
          card.CardPrimary
            header: [h('.panel-title', 'Please Login')]
            body: [
              h form_email_login,
                submit: mock_login_submit
            ]
        ]
        h '.col-sm-3', [
          h ModalLoginForm
        ]
      ]
    ]
