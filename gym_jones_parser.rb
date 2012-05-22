require 'hpricot'
require 'open-uri'

img_count = 0
t = Time.parse("20081209")

until t.month == 12 and t.day == 15
  doc = Hpricot(URI.parse("http://www.gymjones.com/schedule.php?date=#{@t.strftime('%Y%m%d')}").read)
  images = doc.search("/html/body//img")

  images.each do |i|
    src = i.attributes["src"]
    unless ["images/weight1.jpg", "images/weight2.jpg", "images/thedude.jpg", "images/gymjones_logo_web.jpg"]
      GymJonesImage.create(:url => i.attributes["src"], :caption => i.following_siblings[1].innerHTML, :date => t)
      img_count = img_count + 1
    end
  end
  
  t = t + 1.days
end