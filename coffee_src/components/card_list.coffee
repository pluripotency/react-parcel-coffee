h = require 'react-hyperscript'
React = require 'react'

_ = require 'lodash'

applications = [
  'docker'
  'open-vswitch'
  'shibboleth-idp'
  'openldap-server'
  'freeradius'
  'kubeadm'
]

'device'
'gnome-desktop'

menu = [
  name: 'Shibboleth IdP'
  tags: [
    'shibboleth'
    'idp'
  ]
  dependencies: [

  ]

  children: [
    name: 'IdP'
    rel: [
      ['openldap', 'server']
    ]
    'SP'
  ]
,
  name: 'openldap'
  children: [
    'client'
    'server'
  ]
  name: 'radius'
  children: [
    ''
  ]

]

lg_item = (theme)-> 
  if theme
    "li.list-group-item.list-group-item-#{theme}"
  else
    "li.list-group-item"

class MenuList extends React.Component
  constructor: (props)->
    super arguments...
    @state = 
      open: false
  toggle: ()=> @setState open: not @state.open
  render: ()=>
    h lg_item('success'), [
      h 'div',
        onClick: @toggle
      , @props.title
      if @state.open
        h 'ul.list-group.mr-0.pr-0', _.map @props.children, (item)-> h lg_item('info')+'.mr-0.pr-0', item
    ]

class CardList extends React.Component
  constructor: (props)->
    super arguments...

  render: ()=>
    h '.row', [
      h '.col-sm-6.col-md-3', [
        h 'ul.list-group', [
            h MenuList,
              title: 'CentOS'
            , [
              'device setting'
              'gnome-desktop'
            ]
            h MenuList,
              title: 'Applications'
            , [
              'docker'
              'open-vswitch'
              'shibboleth-idp'
              'openldap-server'
              'freeradius'
              'kubeadm'
            ]
        ]
      ]
      h '.col-sm-6.col-md-9', [
        h '.row', [
          h '.col-md-6', [
            h '.card', [
              h '.card-body', [
                'text'
              ]
            ]
          ]
          h '.col-md-6', [
            h '.card', [
              h '.card-body', [
                'text'
              ]
            ]
          ]
        ]
      ]
    ]

module.exports = CardList

