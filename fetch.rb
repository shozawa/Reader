require 'sqlite3'
require 'rss'
require 'open-uri'
require 'time'

def update
  feeds.each do |feed|
    parse_url(feed)
  end
end

def feeds
  File.open('source.txt') do |f|
    f.read.split("\n")
  end
end

def parse_url(source)
  rss = RSS::Parser.parse(source)
  media = rss.channel.link
  articles =  rss.items
  articles.each do |article|
    title = article.title
    link = article.link
    date = article.date.to_i
    puts "- #{media} |  #{title} : #{date}"
  end
end

def subscribe(source)
  return unless rss?(source)
  return unless new_feed?(source)
  File.open('source.txt', 'a') do |f|
    f.puts source
  end
end

def new_feed?(source)
  File.open('source.txt') do |f|
    urls = f.read.split("\n")
    !urls.include?(source)
  end
end

def rss?(source)
  true if RSS::Parser.parse(source)
rescue
  false
end
