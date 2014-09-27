class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->

    @model.on 'change', => @render
    @render()

  render: ->
    @$el.attr('style', @model.get('cardImg')) if @model.get 'revealed'
    @$el.children().detach().end().html
    #@$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

