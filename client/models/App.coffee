#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', undefined
    @set 'disableButtons', false

    # event handlers
    @get('playerHand').on('stand', (hand) =>
      @set 'disableButtons', true
      @dealerPlay() )


  dealerPlay: ->
    hand = @get 'dealerHand'
    hand.at(0).flip()
    scores = hand.scores()
    while scores[0] < 17
      break if scores[1] == 21
      hand.hit()
      scores = hand.scores()
    @setWinner()

  getFinalScore: (hand) ->
    scores = hand.scores()
    score = scores[0]
    score = scores[1]  if scores.length > 1 and scores[1] <= 21
    return score

  setWinner: ->
    playerScore = @getFinalScore(@get 'playerHand')
    dealerScore = @getFinalScore(@get 'dealerHand')

    console.log playerScore, dealerScore
    if playerScore is dealerScore or (playerScore > 21 and dealerScore > 21)
      winner = "tie"
    else if dealerScore > 21 or (playerScore > dealerScore and playerScore <= 21)
      winner = "player"
    else
      winner = "dealer"
    @set "winner", winner

