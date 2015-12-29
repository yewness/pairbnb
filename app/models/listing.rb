class Listing < ActiveRecord::Base
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	belongs_to :user
	has_many :listing_tags
	has_many :tags, through: :listing_tags
	has_many :reservations
	has_many :photos
	mount_uploader :photo, ListingPhotoUploader
	

	def all_tags=(names)
		self.tags = names.split(",").map do |name|
			Tag.where(name: name.strip).first_or_create!
		end
	end

	def all_tags
		self.tags.map(&:name).join(", ")
	end

	def create_tags(tag_string)
	  tag_array = tag_string.gsub(/\s/, "").split(",")
      tag_objs = []
      tag_array.each {|tag|
        tag_obj=Tag.find_or_initialize_by(name: tag)
        tag_obj.save
        tag_objs << tag_obj
      }
      self.tags = tag_objs
	end

	def as_indexed_json(options={})
		self.as_json({
			only: [:title, :description, :city, :photo],
			include: {
				tags: { only: :name},
			}
		})
	end
end

Listing.import