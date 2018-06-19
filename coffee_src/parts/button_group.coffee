h = require 'react-hyperscript'
React = require 'react'

list_example = [
  name: 'Button1'
  klass: 'primary'
,
  name: 'Button2'
,
  name: 'Button3'
]

class ButtonGroup extends React.Component
  constructor: ->
    super arguments...
    @state = index: 0
  select: (i)=> (e)=>
    e.preventDefault()
    if @props.on_index_change?
      @props.on_index_change(i)
    @setState index: i
  render: ()=>
      h '.btn-group', @props.list.map (item, i)=>
        if item.name?
          h "button.btn.btn-#{if item.klass? then item.klass else 'secondary'}",
            onClick: @select(i)
            className: if @state.index == i then 'active' else ''
          , item.name
        else
          h "button.btn.btn-secondary",
            onClick: @select(i)
            className: if @state.index == i then 'active' else ''
          , item

module.exports = ButtonGroup
