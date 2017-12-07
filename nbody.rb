require "gosu"
require "./planets"
require_relative "z_order"

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @planet_list = []
    File.open("planets.txt").each_with_index do |line, i|
      info = line.split(" ")
      if i == 1
        @universe_size = line.to_f
      end
      if i > 1
        planet = Planet.new(info[0].to_f, info[1].to_f, info[2].to_f, info[3].to_f, info[4].to_f, Gosu::Image.new("images/#{info[5]}"), @universe_size)
        @planet_list.push(planet)
      end
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @planet_list.each do |planet|
      planet.draw
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = NbodySimulation.new
window.show