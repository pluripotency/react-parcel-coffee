h = require 'react-hyperscript'
React = require 'react'

tabs_example = [
  name: 'Tab1'
  content: 'tab1 content'
,
  name: 'Tab2'
  content: 'tab2 content'
,
  name: 'Tab3'
  content: 'tab3 content'
]

class Tabs extends React.Component
  constructor: (props)->
    super(props)
    @state = tab_index: 0
  tabClick: (i)=> (e)=>
    e.preventDefault()
    @setState tab_index: i
  render: ()=>
    cur_tab = @props.tabs[@state.tab_index]
    h 'div', [
      h 'ul.nav.nav-tabs', @props.tabs.map (tab, i)=>
        h 'li.nav-item', [
            h 'a.nav-link',
              className: if @state.tab_index == i then 'active'
              onClick: @tabClick(i)
            , tab.name
          ]
      if cur_tab.component?
        h cur_tab.component
      else
        cur_tab.content
    ]

module.exports = Tabs
