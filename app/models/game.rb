class Game < ApplicationRecord
  has_many :offers
  include PgSearch::Model

  pg_search_scope :search_by_title,
    against: [:title],  # ou les colonnes que tu veux rendre recherchables
    using: {
      tsearch: { prefix: true } # permet la recherche partielle
    }
  
  pg_search_scope :search_by_text,
    against: [ :title, :genre, :platform ],
    using: {
      tsearch: { prefix: true }
    }
  
end
