require 'sqlite3'
require 'rss'
require 'open-uri'
require 'time'
require 'uri'

def parse_url(source)
  rss = RSS::Parser.parse(source)
  articles =  rss.items
  articles.each do |article|
    title = article.title
    link = article.link
    date = article.date.to_i
    p "#{date} : #{Time.at(date)}"
  end
end

def subscribe(source)
  if url?(source)
    File.open('source.txt', 'a') do |f|
      f.puts source
    end
  else
  end
end

def url?(source)
  begin
    scheme = URI(source).scheme
    p scheme
  rescue
    ''
  end
  %w(http https).include?(scheme)
end
