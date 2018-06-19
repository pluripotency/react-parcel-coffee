h = require 'react-hyperscript'
React = require 'react'

Card = require './card'
Tabs = require '../tabs'
ButtonGroup = require '../button_group'
InputForm = require '../input/form_input'

klass_obj =
  'light' :'light'
  'dark' :'dark'
  'primary' :'primary'
  'secondary' :'secondary'
  'success' :'success'
  'danger' :'danger'
  'warning' :'warning'
  'info' :'info'

klasses = [
  klass_obj.light
  klass_obj.dark
  klass_obj.primary
  klass_obj.secondary
  klass_obj.success
  klass_obj.danger
  klass_obj.warning
  klass_obj.info
]

class TextInput extends React.Component
  render: ()=>
    h InputForm,
      default_text: @props.default_text
      labelWidth: 3
      inputWidth: 9
      onChange: @props.on_change
      inputType: 'text'
      label: @props.label
      placeholder: ''

class TextInputList extends React.Component
  render: ()=>
    h 'div', [
      h TextInput,
        label: 'header text'
        default_text: @props.default_value('header_text')
        on_change: @props.on_text_change('header_text')
      h TextInput,
        label: 'body text'
        default_text: @props.default_value('body_text')
        on_change: @props.on_text_change('body_text')
      h TextInput,
        label: 'footer text'
        default_text: @props.default_value('footer_text')
        on_change: @props.on_text_change('footer_text')
    ]

class ColorButtons extends React.Component
  constructor: ->
    super arguments...
  render: ()=>
    h 'div', @props.list.map (item)=>
      h 'div', [
        h 'h4', item.title
        h ButtonGroup,
          on_index_change: item.on_index_change
          list: [
            (klasses.map (k)-> { name: k, klass: k })...
            { name: 'None', klass: '' }
          ]
      ]

class PropertyBox extends React.Component
  constructor: ->
    super arguments...
    @state =
      cur_tab: 0
  on_tab_index_change: (i)=>
    ()=>
      @setState cur_tab: i
  render: ()=>
    h Card,
      header:
        text: h 'ul.nav.nav-tabs.card-header-tabs', [
            'text'
            'body'
            'header'
            'footer'
          ].map (item, i)=>
            h 'li.nav-item', [
              h 'a.nav-link',
                className: if @state.cur_tab == i then 'active' else ''
                onClick: @on_tab_index_change(i)
              , item
            ]
      body:
        text: switch @state.cur_tab
          when 0
            h TextInputList,
              default_value: @props.default_value
              on_text_change: @props.on_text_change

          when 1
            h ColorButtons,
              list: [
                'border'
                'body'
                'body_text'
              ].map (item)=>
                title: item + ' class'
                on_index_change: @props.on_index_change(item)
          when 2
            h ColorButtons,
              list: [
                'header'
                'header_text'
              ].map (item)=>
                title: item + ' class'
                on_index_change: @props.on_index_change(item)
          when 3
            h ColorButtons,
              list: [
                'footer'
                'footer_text'
              ].map (item)=>
                title: item + ' class'
                on_index_change: @props.on_index_change(item)

card_klasses = [
  'body'
  'body_text'
  'border'
  'header'
  'header_text'
  'footer'
  'footer_text'
]

text_klasses = [
  'body_text'
  'header_text'
  'footer_text'
]

properties = [
  name: 'body_class_index'
  value: 0
,
  name: 'body_text_class_index'
  value: 1
,
  name: 'border_class_index'
  value: 0
,
  name: 'header_class_index'
  value: 2
,
  name: 'header_text_class_index'
  value: 1
,
  name: 'footer_class_index'
  value: 7
,
  name: 'footer_text_class_index'
  value: 1
,
  name: 'body_text'
  value: 'this is body'
,
  name: 'header_text'
  value: 'Card header'
,
  name: 'footer_text'
  value: 'Card footer'
]

class CardExample extends React.Component
  constructor: ->
    super arguments...
    obj = properties.reduce (sum, item)=>
      sum[item.name] = item.value
      sum
    , {}
    @state = obj
  on_index_change: (item)=> (index)=>
    obj = {}
    obj[item+'_class_index'] = index
    @setState obj
  on_text_change: (item)=> (value)=>
    obj = {}
    obj[item] = value
    @setState obj
  default_value: (item)=>
    @state[item]
  render: ()=>
    h '.row', [
      h '.col-sm-12', [
        h PropertyBox,
          default_value: @default_value
          on_index_change: @on_index_change
          on_text_change: @on_text_change
      ]
      h '.col-sm-12', [
        h 'hr'
      ]
      h '.col-sm-4', [
        h 'h4', 'body only'
        h Card,
          border_theme: klasses[@state.border_class_index]
          body:
            theme: klasses[@state.body_class_index]
            text: if @state.body_text
                @state.body_text
              else
                h 'div', [
                  h 'p', "body class: #{klasses[@state.body_class_index]}"
                  h 'p', "body text class: #{klasses[@state.body_text_class_index]}"
                ]
            text_theme: klasses[@state.body_text_class_index]
      ]
      h '.col-sm-4', [
        h 'h4', 'with header'
        h Card,
          border_theme: klasses[@state.border_class_index]
          body:
            theme: klasses[@state.body_class_index]
            text: if @state.body_text
              @state.body_text
            else
              h 'div', [
                h 'p', "body class: #{klasses[@state.body_class_index]}"
                h 'p', "body text class: #{klasses[@state.body_text_class_index]}"
              ]
            text_theme: klasses[@state.body_text_class_index]
          header:
            theme: klasses[@state.header_class_index]
            text: if @state.header_text
              @state.header_text
            else
              h 'div', [
                h 'p', "header class: #{klasses[@state.header_class_index]}"
                h 'p', "header text class: #{klasses[@state.header_text_class_index]}"
              ]
            text_theme: klasses[@state.header_text_class_index]
      ]
      h '.col-sm-4', [
        h 'h4', 'with header and footer'
        h Card,
          border_theme: klasses[@state.border_class_index]
          header:
            theme: klasses[@state.header_class_index]
            text: if @state.header_text
              @state.header_text
            else
              h 'div', [
                h 'p', "header class: #{klasses[@state.header_class_index]}"
                h 'p', "header text class: #{klasses[@state.header_text_class_index]}"
              ]
            text_theme: klasses[@state.header_text_class_index]
          body:
            theme: klasses[@state.body_class_index]
            text: if @state.body_text
              @state.body_text
            else
              h 'div', [
                h 'p', "body class: #{klasses[@state.body_class_index]}"
                h 'p', "body text class: #{klasses[@state.body_text_class_index]}"
              ]
            text_theme: klasses[@state.body_text_class_index]
          footer:
            theme: klasses[@state.footer_class_index]
            text: if @state.footer_text
              @state.footer_text
            else
              h 'div', [
                h 'p', "header class: #{klasses[@state.header_class_index]}"
                h 'p', "header text class: #{klasses[@state.header_text_class_index]}"
              ]
            text_theme: klasses[@state.footer_text_class_index]
      ]
    ]

module.exports = CardExample
