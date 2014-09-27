class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button"
    <%if (disableButtons){ %>
     disabled
    <% } %>
    >Hit</button> <button class="stand-button"
    <%if (disableButtons) { %>
      disabled
    <% } %>
    >Stand</button>
    <button class="reset-button">Reset</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>

    <% if (typeof winner !== undefined) {%>
      <div class="winner"><%= winner %></div>
      <%}%>
   '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .reset-button": -> @model.initialize()
    #"change:winner": -> @render()

  initialize: ->
    @render()
    @model.on 'change', => @render()

  render: ->
    @$el.children().detach()
    # if @model.get('winner')?
    #   debugger
    @$el.html @template(@model.attributes)
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
