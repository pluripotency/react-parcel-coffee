h = require 'react-hyperscript'
React = require 'react'
alerts = require './alert'

klass_obj =
  'primary' :'primary'
  'secondary' :'secondary'
  'success' :'success'
  'danger' :'danger'
  'warning' :'warning'
  'info' :'info'
  'light' :'light'
  'dark' :'dark'

klasses = [
  klass_obj.primary
  klass_obj.secondary
  klass_obj.success
  klass_obj.danger
  klass_obj.warning
  klass_obj.info
  klass_obj.light
  klass_obj.dark
]

class Table extends React.Component
  render: ()=>


class TableExample extends React.Component
  constructor: ()->
    super(arguments...)

  render: ()=>
    thead_color = '.thead-dark'
    h "table.table#{}", [
      h "thead#{thead_color}",[
          h 'tr', [
            '#'
            'First'
            'Second'
            'Third'
          ].map (head)=> h 'th', head
        ]
      h 'tbody', [
        [
          0
          1
          2
          3
        ]
        [
          0
          1
          2
          3
        ]
      ].map (row, j)-> h 'tr', key: j, row.map (col, i)-> h 'td', key: i, col
    ]

module.exports = TableExample
    
    
    