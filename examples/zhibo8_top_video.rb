require_relative("../lib/fetch_news.rb")

# when page is async loading by js file
FetchNews.configure do |configuration|
  configuration.browser = "chrome"
  configuration.headless = true
end

zhibo8 = FetchNews.init("dynamic")
zhibo8.go("https://www.zhibo8.cc/nba/")
divElement = zhibo8.browser.div(id: "hot_video").wait_until(&:exists?)
target_html = divElement.children

p "lanuch complete====>"
ulList = target_html.find { |ele| ele.instance_of?(Watir::UList)}

result = zhibo8.get_content(ulList) do |link|
  liArray = link.children.to_a
  orderItem = liArray.find { |item| item.tag_name === "span"}
  order = orderItem ? orderItem.text : nil 
  
  news = liArray.find { |item| item.tag_name === "a"}
  url = news.attribute_value("href")

  unless url.nil?
    { 
      index: order,
      url: url,
      text: news.text
    }
  end
end

p result

zhibo8.quit
