{View, EditorView} = require 'atom'
AtomTeatimerStatusView = require './atom-teatimer-status-view'

module.exports =
class AtomTeatimerView extends View
  @content: ->
    @div class: 'atom-teatimer overlay from-top', =>
      @div 'Set timer in seconds:'
      @subview 'timerValue', new EditorView(mini: true)

  initialize: (serializeState) ->
    atom.workspaceView.command "atom-teatimer:toggle", => @toggle()
    @on 'core:confirm', @addTimer
    @on 'core:cancel', @detach

    @timerValue.on 'pane:became-inactive', ->
      console.log 'inactive'

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
      @timerValue.focus()

  addTimer: =>
    @detach()
    @statusView = new AtomTeatimerStatusView
    atom.workspaceView.statusBar.appendLeft(@statusView)

    @statusView.start(@timerValue.getText())
