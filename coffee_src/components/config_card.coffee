h = require 'react-hyperscript'
React = require 'react'

_ = require 'lodash'


class HostTable extends React.Component
  constructor: (props) ->
    super arguments...
    @state =
      search: ''
      editing_row: ''
      reorder: false
      temp_rows: []
      rows: props.hosts

  input_search: (value)=>
    @setState
      search: value
  clear_search: ()=>
    @setState
      search: ''
  set_default: ()=>
    @setState
      search: ''
      editing_row: ''
      reorder: false
      temp_rows: []
  start_edit: (i)=>
    ()=>
      if @state.editing_row!=i
        @set_default()
        @setState editing_row: i
        setTimeout ()=>
          document.querySelector("#input#{i}").focus()
        , 200
  toggle_checked: (i)=> ()=>
    rows = @state.rows
    rows[i].checked = !rows[i].checked
    @setState
      rows: rows
  select_hkey: (row_index, hkey_index)=>()=>
    rows = @state.rows
    rows[row_index].selected_hkey_index = hkey_index
    @setState
      rows: rows


  on_click_reorder: (e)=>
    e.preventDefault
    if @state.reorder
      temp_rows = @state.temp_rows
      drop_rows = _.reject @state.rows, (r)-> _.find temp_rows, (t)-> t.name == r.name
      new_rows = [
        temp_rows...
        drop_rows...
      ]
      @setState 
        rows: new_rows
        temp_rows: []
        reorder: false
    else
      @set_default()
      @setState reorder: true
  render: ()=>
    rows = _(@state.rows)
      .filter (r)=> 
        if @state.search
          r.name.match(new RegExp(@state.search))
        else
          true
      .value()
    h 'table.table.table-sm.table-hover', [
      h 'thead.bg-info', [
        h 'tr', [
          h 'th', [h 'i.far.fa-check-square']
          h 'th', '#'
          (_.map @props.headers, (head)-> h 'th', head)...
          h 'th', [
            h 'button.btn.btn-sm.btn-primary',
              onClick: (e)=>
                e.preventDefault()
                current_rows = @state.rows
                current_rows.push name: ''
                @setState 
                  rows: current_rows
                  editing_rows: current_rows.length-1
            , 'Add'
          ]
        ]
      ]
      h 'tbody', _.map @state.temp_rows, (row, i)=>
        h 'tr', [
          h 'td', i+1
          h 'td', row.name
        ]
      h 'tbody', _.map rows, (row, i)=>
          h 'tr', [
            h 'td', [
              h 'i.far.fa-check-square',
                className: if row.checked then 'fa-check-square' else 'fa-square'
                onClick: @toggle_checked(i)
            ]
            h 'td', [
              if @state.reorder
                h 'button.btn.btn-sm.btn-secondary',
                  onClick: ()=>
                    temp_rows = @state.temp_rows
                    if not _.find(temp_rows, (r)-> row.name == r.name)
                      temp_rows.push row
                      @setState temp_rows: temp_rows
                , 'select'
              else
                i+1
            ]
            h 'td', [
                if @state.editing_row==i
                  h '.input-group.input-group-sm', [
                    h 'input.form-control',
                      id: "input#{i}"
                      onChange: (e)=>
                        rows = @state.rows
                        rows[i].name = e.target.value
                        @setState rows: rows
                      value: row.name
                  ]
                else
                  h 'label', row.name
              ]
            h 'td', [
              ((row.hkeys?.map (hkey, j)=> 
                h 'button.btn.btn-sm.btn-info',
                  className: if row.selected_hkey_index==j then 'active' else ''
                  onClick: @select_hkey(i, j)
                , j
              ) or [h 'button.btn.btn-sm.btn-danger', [h 'i.fas.fa-sync']])...
            ]
            h 'td', [
                if @state.editing_row !=''
                  if @state.editing_row == i
                    h 'button.btn.btn-sm.btn-primary',
                     onClick: ()=> 
                      rows = @state.rows
                      @setState
                        editing_row: ''
                        rows: _.reject rows, (r)-> r.name == ''
                    , 'Save'
                  else
                    h 'div'
                else
                  h 'button.btn.btn-sm.btn-primary',
                    onClick: @start_edit(i)
                  , 'Edit'
              ]
            ]
      h 'tfoot', [
        h 'tr', [
          h 'td',
            colSpan: 2
          , [
            h 'button.btn.btn-sm',
              onClick: @on_click_reorder
            , if @state.reorder then 'done' else 'reorder'
          ]
          h 'td',
            colSpan: 2
          , [
            h SearchForm,
              input_search: @input_search
              clear_search: @clear_search
              set_default: @set_default
          ]
          h 'td', [
            h 'button.btn.btn-sm.btn-primary',
              onClick: @props.run
            , 'Run'
          ]
        ]
      ]
    ]

class SearchForm extends React.Component
  constructor: ->
    super arguments...
  input_search: (e)=>
    @props.input_search(e.target.value)
  set_default: ()=>
    @props.set_default()
  clear_search: ()=>
    @props.clear_search()
  render: ()=>
    h '.input-group.input-group-sm.mb-3', [
      h 'input.form-control',
        onFocus: @set_default
        onChange: @input_search
      h '.input-group-append', [
        h 'span.input-group-text',
          onClick: @clear_search
        , 'X'
        h 'span.input-group-text', 'Search'
      ]
    ]


class HostsBox extends React.Component
  render: ()=>
    h '.card',
      style:
        position: 'absolute'
        top: '45px'
        margin: '15px'
    , [
      h '.card-header.bg-info', [
        'Hosts'
        h 'button.close', 'x'
      ]
      h HostTable,
        headers: [
          'hostname'
          'hkeys'
        ]
        hosts: [
          name: 'item1'
          hkeys: [
            'sample1'
            'sample2'
          ]
          selected_hkey_index: 0
          checked: true
        ,
          name: 'item2'
        ]
        run: ()=>
    ]

class Background extends React.Component
  constructor: ->
    super arguments...
  render: ()=>
    h 'div',
      style:
        position: 'fixed'
        top: '0'
        left : '0'
        width: '100%'
        height: '100%'
        backgroundColor: '#50c6dd'
    , [
      h HostsBox
    ]


module.exports = Background
