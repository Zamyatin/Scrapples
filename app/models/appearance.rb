class Appearance < ActiveRecord::Base

  belongs_to :player, class_name: 'User'
  belongs_to :game

  has_many :holdings
  has_many :held_cards, through: :holdings, source: :card

  has_many :rounds, through: :game

  validates_presence_of :player
  validates_presence_of :game

  validates :player, uniqueness: { scope: :game,
  message: "must be unique for each game" }

  def draw_card!
    card = self.game.cards_not_drawn.sample
    self.holdings.create(card: card)
    card
  end

  def incremement_point!
    self.points += 1
  end
end
