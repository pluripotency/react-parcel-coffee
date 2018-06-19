h = require 'react-hyperscript'
React = require 'react'

class NavList extends React.Component
  constructor: (props)->
    super arguments...
    @state = index: 0
  select_nav: (index)=>(e)=>
    e.preventDefault()
    @props.select_nav(index)
    @setState index: index
  render: ()=>
    h 'ul.navbar-nav.mr-auto', @props.nav_list.map (item, i)=>
      h 'li.nav-item',
        className: if @state.index == i then 'active'
      , [
          h 'a.nav-link',
            onClick: @select_nav(i)
          , item.name
        ]

class NavBar extends React.Component
  constructor: (props)->
    super arguments...
    @state = collapse: true
  toggle: (e)=>
    e.preventDefault()
    @setState collapse: !@state.collapse
  render: ()=>
    vm = @props.vm
    h "nav.navbar.navbar-expand-md.bg-dark.navbar-dark",
      style: zIndex: 1
    , [
      h 'a.navbar-brand.text-light', vm.title
      h 'button.navbar-toggler',
        onClick: @toggle
      , [h 'span.navbar-toggler-icon']
      h '.navbar-collapse',
        className: if @state.collapse then 'collapse' else 'in'
      , [
        h NavList,
          nav_list: vm.nav_list
          select_nav: vm.select_nav
        ]
    ]

module.exports = NavBar
