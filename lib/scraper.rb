require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        students << {
          :name => student.css("h4.student-name").text,
          :location => student.css("p.student-location").text,
          :profile_url => "#{student.attr('href')}",
          }
        end
      end
  # return the projects hash
  students
  end

  def self.scrape_profile_page(profile_slug)

    html = File.read(profile_slug)
    profile_page = Nokogiri::HTML(html)
    student = {}
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] =link
      elsif link.include?("github")
        student[:github]=link
      elsif condition
        student[:twitter]=link
      else
        student[:blog]=link
      end
    end


student

  end

end
