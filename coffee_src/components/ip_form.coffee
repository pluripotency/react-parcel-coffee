h = require 'react-hyperscript'
React = require 'react'

Card = require '../parts/components/card'

ButtonGroup = require '../parts/button_group'
InputForm = require '../parts/input/form_input'

class TextInput extends React.Component
  render: ()=>
    h InputForm,
      default_text: @props.default_text
      labelWidth: 4
      inputWidth: 8
      onChange: @props.on_change
      inputType: 'text'
      label: @props.label
      placeholder: ''


class IPForm extends React.Component
  on_change: (item)=>(value)=>
  render: ()=>
    h '.row', [
      h '.col-sm-6', [
        h Card,
          header:
            text: 'IP Addresses'
          body:
            text: [
                'segments'
                'ip'
                'gateway'
                'dns'
              ].map (item)=>
                h TextInput,
                  default_text: ''
                  on_change: @on_change
                  label: item
        ]
    ]

module.exports = IPForm

