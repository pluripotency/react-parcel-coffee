import h from 'react-hyperscript'
import React, {useState} from 'react'


Example = ()->
  [count, setCount] = useState(0)
  h 'div', [
    h 'p', "You clicked #{count} times"
    h 'button',
      onClick: ()-> setCount(count+1)
    , 'click me'
  ]

module.exports = Example
