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

class NavDropDownItem extends React.Component
  render: ()=>
    h "li.nav-item.dropdown#{if @state?.show? then '.show' else ''}",
      onClick: ()=>
        if @state?.show?
          @setState show: null
        else
          @setState show: true
    , [
        h 'a.nav-link.dropdown-toggle', href: '#', 'Dropdown'
        h ".dropdown-menu#{if @state?.show? then '.show.fade-in' else ''}", @props.children
      ]

class Navbar extends React.Component
  constructor: ()->
    super(arguments...)

  render: ()=>
#    navbar_color = '.navbar-dark'
#    bg_color = '.bg-primary'
    title = @props.title
    navbar_color = @props.navbar_color
    bg_color = @props.bg_color
    h "nav.navbar.navbar-expand-md#{navbar_color}#{bg_color}", [
      h 'a.navbar-brand', href: '#', title
      h "button.navbar-toggler",
        onClick: ()=>
          if @state?.navbar?
            @setState navbar: null
          else
            @setState navbar: true
      , [
          h 'span.navbar-toggler-icon'
        ]
      h ".navbar-collapse#{if @state?.navbar? then '.fade-in' else '.collapse'}", @props.children
    ]


class NavbarExample extends React.Component
  constructor: ()->
    super(arguments...)

  render: ()=>
    h Navbar,
      title: 'Navbar'
      navbar_color: '.navbar-light'
      bg_color: '.bg-light'
    , [
        h 'ul.navbar-nav.mr-auto', [
          h 'li.nav-item.active', [
            h 'a.nav-link', href: '#', 'Home'
          ]
          h 'li.nav-item', [
            h 'a.nav-link', href: '#', 'Link'
          ]
          h NavDropDownItem, [
            h 'a.dropdown-item', href: '#', 'Action'
            h 'a.dropdown-item', href: '#', 'Another action'
            h '.dropdown-divider'
            h 'a.dropdown-item', href: '#', 'Something else here'
          ]
          h 'li.nav-item', [
            h 'a.nav-link.disabled', href: '#', 'Link'
          ]
        ]
        h 'form.form-inline.my-2.my-lg-0', [
          h 'input.form-control.mr-sm-2'
          h 'button.btn.btn-outline-success.my-2.my-sm-0', 'Search'
        ]
    ]

module.exports = NavbarExample
    
    
    