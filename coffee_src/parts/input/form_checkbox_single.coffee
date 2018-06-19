h = require 'react-hyperscript'
React = require 'react'

class FormSingleCheckbox extends React.Component
  constructor: (props)->
    super(props)
    @state =
      checked: if props.checked? then props.checked else false
  onChange: (e)=>
    value = e.target.value
    @setState
      checked: value
  render: ()=>
    label_width = @props.labelWidth or 3
    input_width = @props.inputWidth or 9
    h '.form-group.row', [
      h "label.col-sm-#{label_width}.col-form-label"
      h ".col-sm-#{input_width}", [
        h 'input',
          type: 'checkbox'
          onChange: @onChange
        ' ' + @props.label
      ]
    ]

props_example =
  labelWidth: 3
  inputWidth: 9
  onChange: 'function'
  label: 'Username'

module.exports = FormSingleCheckbox
