require "gosu"

class Planet

	attr_reader :x, :y, :z, :vel_x, :vel_y, :vel_z, :mass, :image, :universe_size


	def initialize(x,y,z,vel_x,vel_y,vel_z,mass,image,universe_size)
		@x = x
		@y = y
		@z = z
		@vel_x = vel_x
		@vel_y = vel_y
		@vel_z = vel_z
		@mass = mass
		@image = image
		@universe_size = universe_size
		@force_x = 0
		@force_y = 0
		@force_z = 0
		@times_spilt = 0
	end 
	GC = 6.674e-11
	TIME = 25000

	def force_x(planet2)
		force = (GC * planet2.mass * @mass) / ((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y))
		@force_x += force * ((planet2.x - @x) / Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y)))
	end

	def force_z(planet2)
		force = (GC * planet2.mass * @mass) / ((planet2.x - @x)*(planet2.x - @x) + (planet2.z - @z)*(planet2.z - @z))
		@force_z += force * ((planet2.z - @z) / Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.z - @z)*(planet2.z - @z)))
	end

	def force_y(planet2)
		force = (GC * planet2.mass * @mass) / ((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y))
		@force_y += force * ((planet2.y - @y) / Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y)))
	end

	def accel_x()
		accel_x = @force_x/@mass
		@vel_x += accel_x * TIME
		@x += @vel_x * TIME
	end

	def accel_z()
		accel_z = @force_z/@mass
		@vel_z += accel_z * TIME
		@z += @vel_z * TIME
	end

	def accel_y()
		accel_y = @force_y/@mass
		@vel_y += accel_y * TIME
		@y += @vel_y * TIME
	end

	def reset_force()
		@force_x = 0
		@force_y = 0
		@force_z = 0
	end

	def collision?
    	if Gosu.distance(@x, @y) < 35
          true
          times_spilt += 1 
        else
          false
        end
    end


	def draw()
		y_c = ((-@y/@universe_size)*320) + 320 - (@image.height/2)
		x_c = ((@x/@universe_size)*320) + 320 - (@image.width/2)
		z_c = ((@z/@universe_size)*320) + 320 - (@image.depth/2)

		if z_c = 0
			@image.draw(x_c, y_c, z_c)
		end

		if z_c > universe_size
			@image.draw(x_c, y_c, z_c*5)
		end

		if z_c < universe_size
			@image.draw(x_c, y_c, z_c*0.2)
		end

	end

	def draw_split
		x_c = ((@x/@universe_size)*320) + 320 - (@image.width/(2^times_spilt))
		y_c = ((-@y/@universe_size)*320) + 320 - (@image.height/(2^times_spilt))
		z_c = ((@z/@universe_size)*320) + 320 - (@image.depth/(2^times_spilt))
		@image.draw(x_c/(2^times_spilt), y_c/(2^times_spilt), z_c/(2^times_spilt))
		@image.draw(x_c/(2^times_spilt), y_c/(2^times_spilt), z_c/(2^times_spilt))
	end

end