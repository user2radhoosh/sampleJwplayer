import React, { Component } from 'react'
import { requireNativeComponent } from 'react-native'

export default class JwPlayerWrapperView extends Component {

  setNativeProps = nativeProps => {
    if (this._root) {
      this._root.setNativeProps(nativeProps);
    }
  }

  render() {
    return <JwPlayerWrapper
      ref={e => (this._root = e)}
      {...this.props}
      onFullScreen={event =>
        this.props.onFullScreen && this.props.onFullScreen(event.nativeEvent)
      }
    />
  }
}

const JwPlayerWrapper = requireNativeComponent('HelloWorldSquare', JwPlayerWrapperView)