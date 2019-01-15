class Comment < ApplicationRecord
  def self.generate_captcha
    n, y, x = (100..999).to_a.sample(3).sort
    z = x + y - n

    { x: x,
      y: y,
      z: z,
      n: n }
  end
end
