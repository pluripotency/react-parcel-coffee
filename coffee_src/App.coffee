h = require 'react-hyperscript'
React = require 'react'

NavBar = require './parts/navbar'
vm = require './ViewModel/index'

class App extends React.Component
  constructor: (props)->
    super arguments...
    document.title = vm.title
    @state =
      nav_index: 0
    vm.bindSetAppState @setState.bind @
  render: ()=>
    h '.container', [
      h NavBar,
        vm: vm
      h vm.nav_list[@state.nav_index].component,
        vm: vm
    ]

module.exports = App
