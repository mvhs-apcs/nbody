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
		@force_x = 0
		@force_y = 0
	end 
	GC = 6.674e-11
	TIME = 25000

	def force_x(planet2)
		force = (GC * planet2.mass * @mass) / ((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y))
		@force_x += force * ((planet2.x - @x) / Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y)))
	end

	def force_y(planet2)
		force = (GC * planet2.mass * @mass) / ((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y))
		@force_y -= force * ((planet2.y - @y) / Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y)))
	end

	def accel_x()
		accel_x = @force_x/@mass
		@vel_x += accel_x * TIME
		@x += @vel_x * TIME
	end

	def accel_y()
		accel_y = @force_y/@mass
		@vel_y += accel_y * TIME
		@y -= @vel_y * TIME
	end

	def reset_force()
		@force_x = 0
		@force_y = 0
	end

	def draw()
		x_c = ((@x/@universe_size)*320) + 320 - (@image.width/2)
		y_c = ((@y/@universe_size)*320) + 320 - (@image.height/2)
		@image.draw(x_c, y_c, 0)
	end

end