require "gosu"

class Planet

	attr_reader :x, :y, :vel_x, :vel_y, :mass, :image, :universe_size


	def initialize(x,y,vel_x,vel_y,mass,image,universe_size)
		@x = x
		@y = y
		@vel_x = vel_x
		@vel_y = vel_y
		@mass = mass
		@image = image
		@universe_size = universe_size
	end 

	def draw()
		x = ((@x/@universe_size)*320) + 320
		y = ((@y/@universe_size)*320) + 320
		@image.draw(x, y, 0)
	end

	

	def move
	end

end