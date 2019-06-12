require_relative("../lib/fetch_news.rb")

baidu = FetchNews.init("static")
baidu.go("http://top.baidu.com/")
target_html = baidu.page.search("#hot-list")[0].children.search("li")

result = baidu.get_content(target_html) do |link|
  orderItem = link.search("span.num-normal", "span.num-top")[0]
  order = orderItem ? orderItem.text : nil 
  news = link.search("a")[0]
  url = news.key?("href") ? news.attribute("href").value : nil

  unless url.nil?
    { 
      index: order,
      url: url,
      text: news.text
    }
  end
end

p result