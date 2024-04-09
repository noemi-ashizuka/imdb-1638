require_relative "../scraper"

describe "#scrape_top_5_urls" do
  it "returns an array of the top 5 movies urls (as strings)" do
    expected = [
      "https://www.imdb.com/title/tt0111161/",
      "https://www.imdb.com/title/tt0068646/",
      "https://www.imdb.com/title/tt0468569/",
      "https://www.imdb.com/title/tt0071562/",
      "https://www.imdb.com/title/tt0050083/"
    ]
    expect(scrape_top_5_urls()).to eq(expected)
  end
end

describe "#scrape_movie(url)" do
  it "returns a hash with all the movie information" do
    url = "https://www.imdb.com/title/tt0111161/"
    movie = {
      cast: ["Tim Robbins", "Morgan Freeman", "Bob Gunton"],
      director: "Frank Darabont",
      storyline: "Over the course of several years, two convicts form a friendship, seeking consolation and, eventually, redemption through basic compassion.",
      title: "The Shawshank Redemption",
      year: 1994,
      rating: 9.39
    }
    expect(scrape_movie(url)).to eq(movie)
  end
end
