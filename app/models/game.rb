class Game < ApplicationRecord
  has_many :offers

  include PgSearch::Model
  pg_search_scope :search_by_text,
    against: [ :title, :genre, :platform ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
