//  Created by react-native-create-bridge

import React, { Component } from 'react'
import { requireNativeComponent } from 'react-native'

const HelloWorldSquare = requireNativeComponent('HelloWorldSquare', HelloWorldSquareView)

export default class HelloWorldSquareView extends Component {
  render () {
    return <HelloWorldSquare {...this.props} />
  }
}