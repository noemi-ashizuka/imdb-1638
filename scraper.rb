# Create a method to get the top 5 urls from https://www.imdb.com/chart/top/
# scrape_top_5_urls => array of strings
require "open-uri"
require "nokogiri"

def scrape_top_5_urls
  url = "https://www.imdb.com/chart/top/"
  html_doc = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read

  doc = Nokogiri::HTML(html_doc)

  urls = []
  # doc.search(".sc-b0691f29-1.grHDBY")
  doc.search(".ipc-title-link-wrapper").first(5).each do |element|
    urls << "https://www.imdb.com#{element.attribute("href").value.split("?").first}"
  end

  urls
end

# p scrape_top_5_urls

# Create a method to scrape movie data from a specific movie page (ex. https://www.imdb.com/title/tt0111161/) - Title, Director, Cast, Year, Storyline, Rating

# scrape_movie(url) => hash

def scrape_movie(url)
  html_doc = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read

  doc = Nokogiri::HTML(html_doc)

  year = doc.search('.ipc-link.ipc-link--baseAlt.ipc-link--inherit-color')[5].text.strip.to_i
  director = doc.search('.ipc-metadata-list-item__list-content-item.ipc-metadata-list-item__list-content-item--link').first.text.strip

  storyline = doc.search('.sc-466bb6c-2.chnFO').text.strip
  title = doc.search('.hero__primary-text').text.strip
  rating = doc.search('.cMEQkK').text.strip[0..3].to_f

  cast = doc.search('.sc-bfec09a1-1.gCQkeh').first(3).map do |element|
    element.text
  end

  {
    cast: cast,
    rating: rating,
    title: title,
    director: director,
    year: year,
    storyline: storyline
  }
end

# p scrape_movie("https://www.imdb.com/title/tt0111161/")
