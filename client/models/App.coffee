#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', undefined
    @set 'playerScore', 0
    @set 'dealerScore', 0
    # debugger

    # event handlers
    @get('playerHand').on('stand', (hand) =>
      @setScore hand
      @dealerPlay() )
    @get('dealerHand').on('stand', (hand) =>
      @setScore hand )

  setScore: (hand) ->
    scores = hand.scores()
    score = scores[0]
    score = scores[1]  if scores.length > 1 and scores[1] <= 21
    if hand.isDealer
      @set 'dealerScore', score
    else
      @set 'playerScore', score
    return

  dealerPlay: ->
    hand = @get 'dealerHand'
    hand.at(0).flip()
    scores = hand.scores()
    while scores[0] < 17
      break if scores[1] == 21
      hand.hit()
      scores = hand.scores()
    @setScore(hand)
    @setWinner()

  setWinner: ->
    playerScore = @get('playerScore')
    dealerScore = @get('dealerScore')

    if playerScore is dealerScore or (playerScore > 21 and dealerScore > 21)
      winner = "tie"
    else if playerScore > dealerScore
      winner = "player"
    else
      winner = "dealer"
    @set "winner", winner

