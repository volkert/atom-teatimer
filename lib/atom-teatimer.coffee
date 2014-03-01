AtomTeatimerView = require './atom-teatimer-view'

module.exports =
  atomTeatimerView: null

  activate: (state) ->
    @atomTeatimerView = new AtomTeatimerView(state.atomTeatimerViewState)

  deactivate: ->
    @atomTeatimerView.destroy()

  serialize: ->
    atomTeatimerViewState: @atomTeatimerView.serialize()
