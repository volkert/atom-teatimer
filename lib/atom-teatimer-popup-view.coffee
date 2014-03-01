{View} = require 'atom'

module.exports =
class AtomTeatimerPopupView extends View
  @content: ->
    @div class: 'atom-teatimer overlay from-top teaready', =>
        @span class: 'inline-block highlight-success', 'Your tea is ready!'

  initialize: ->
    @on 'click', @detach
