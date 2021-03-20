class Address < ApplicationRecord
  belongs_to :request

  def to_param
    "#{space_to_plus(street)},#{space_to_plus(neighborhood)}, #{space_to_plus(city)}, #{space_to_plus(uf)}"
  end

  private

  def space_to_plus(value)
    value.gsub(' ', '+')
  end
end
