class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :movie_genres
  has_many :genres, through: :movie_genres
  
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  mount_uploader :movie_poster, MoviePosterUploader

  scope :search_like, ->(query) { where('title LIKE :q OR director LIKE :q', q: "%#{query}%")}

  scope :runtime_over, ->(time) { where('runtime_in_minutes >= ?', time) if !time.blank? }
  scope :runtime_under, ->(time) { where('runtime_in_minutes <= ?', time) if !time.blank? }

  def self.search(search)
    if search
      search_like(search['query']).runtime_over(search['duration_a']).runtime_under(search['duration_b'])
    else
      all
    end
  end

  def review_average
    if reviews.size > 0
      reviews.sum(:rating_out_of_ten)/reviews.size
    else
      0
    end
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
