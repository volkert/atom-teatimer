{View} = require 'atom'
AtomTeatimerPopupView = require './atom-teatimer-popup-view'

module.exports =
class AtomTeatimerStatusView extends View
  @content: ->
    @div class: 'inline-block', =>
      @span class: "highlight-info", =>
        @span "TeaTimer: "
        @span outlet: "teaTimer", tabindex: '-1', ""

  start: (seconds) ->
    @startTime = (new Date).getTime()
    @endTime = @startTime + parseInt(seconds, 10) * 1000
    @teaTimer.text(seconds)

    if @runningTimer
      console.log 'a timer is running'
      @stop()

    @runningTimer = setInterval =>
      now = (new Date).getTime()
      if @endTime > now
        @teaTimer.text(Math.round((@endTime - now) / 1000))
      else
        @stop()
        atom.beep()
        atom.workspaceView.append(new AtomTeatimerPopupView)
        @detach()
    , 1000

  stop: ->
    console.log 'stopping'
    clearInterval(@runningTimer)
