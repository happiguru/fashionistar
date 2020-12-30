class Post < ApplicationRecord
    validates :image, presence: true

    has_one_attached :image, style: { :medium => "640x" }
    validates_attached_content_type :image, :content_type => /\Aimage\/.*\Z/    
end
