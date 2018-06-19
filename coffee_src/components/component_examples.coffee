h = require 'react-hyperscript'
React = require 'react'

Tabs = require '../parts/tabs'

tab_list = [
  name: 'Alerts'
  component: require '../parts/components/alerts_example'
,
  name: 'Card'
  component: require '../parts/components/card_example'
,
  name: 'Table'
  component: require '../parts/components/table_example'
,
  name: 'Navbar'
  component: require '../parts/components/navbar_example'
,
  name: 'Form'
  component: require './ip_form'
]

class ComponentExamples extends React.Component
  render: ()=>
    h Tabs,
      tabs: tab_list

module.exports = ComponentExamples

