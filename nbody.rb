require "gosu"
require "./planets"
require_relative "z_order"

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @planet_list = []
    planets_counter = 0
    input = ARGV
    filename = input[0]
    File.open("simulations/#{filename}").each_with_index do |line, i|
      info = line.split(" ")
      if i == 1
        @universe_size = line.to_f
      end
      if i == 0
        @number_of_planets = line.to_f
      end
      if i > 1
        if info[0] != nil  
          planet = Planet.new(info[0].to_f, info[1].to_f, info[2].to_f, info[3].to_f, info[4].to_f, Gosu::Image.new("images/#{info[5]}"), @universe_size)
          @planet_list.push(planet)
          planets_counter += 1
        end
      end
      puts planets_counter
      if planets_counter == @number_of_planets
        break
      end
    end
  end

  def update
    @planet_list.each do |planet1|
      @planet_list.each do |planet2|
        if planet1 !=  planet2
          planet1.force_y(planet2)
          planet1.force_x(planet2)
          planet1.force_z(planet2)
        end
      end
      planet1.accel_y()
      planet1.accel_x()
      planet1.accel_z()
      planet1.reset_force()
    end
  end


  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @planet_list.each do |planet|
      if collision = true
        planet.draw_split
      end
      planet.draw
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = NbodySimulation.new
window.show