h = require 'react-hyperscript'
React = require 'react'

card = require '../parts/card'


module.exports = ()->
  card.CardPrimary
    header: [h 'h4', 'font awesome']
    body: [
      h 'i.fas.fa-user'
      h 'i.far.fa-user'
      h 'i.fab.fa-github'
      h 'i.fas.fa-check-square.text-success'
    ]


