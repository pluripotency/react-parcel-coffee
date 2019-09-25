vm =
  title: 'React Parcel Coffee'
  bindSetAppState: (f)->
    vm.setAppState = f
  select_nav: (index)->
    vm.setAppState nav_index: index
  nav_list: [
    name: 'Home'
    url: '/'
    component: require '../components/component_examples'
  ,
    name: 'Hook'
    url: '/hook'
    component: require '../components/hook'
  ,
    name: 'CardList'
    url: '/cardlist'
    component: require '../components/card_list'
  ,
    name: 'Config Card'
    url: '/config'
    component: require('../components/config_card')
  ]

module.exports = vm
