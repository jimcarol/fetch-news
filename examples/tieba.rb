require_relative("../lib/fetch_news.rb")

# when page is async loading by js file
FetchNews.configure do |configuration|
  configuration.browser = "chrome"
  configuration.headless = true
end

zhibo8 = FetchNews.init("dynamic")
zhibo8.go("https://tieba.baidu.com/f?kw=nba")
divElement = zhibo8.browser.div(id: "pagelet_frs-list/pagelet/thread_list").wait_until(&:exists?)
target_html = divElement.children[0].to_a

puts target_html, "-----"
# p "lanuch complete====>"
# ulList = target_html.find { |ele| ele.instance_of?(Watir::UList)}

result = zhibo8.get_content(target_html) do |link|
  liArray = link.children.to_a

  # puts "----------------->"
  #   puts liArray[0].children
  #   puts liArray[0].span(class: ["pull_right", "label_text"]).exists? && liArray[0].span(class: ["pull_right", "label_text"]).text
  # puts "----------------->"
  row = liArray[0].span(class: ["pull_right", "label_text"])

  unless row.exists? && row.text === "广告"
    body = liArray[0].div(class: "threadlist_lz")

    title = body.a(class: "j_th_tit ").text
    link = body.element(tag_name: "a").attribute_value("href")
    author = body.span(class: "tb_icon_author").attribute_value("title")
    author_link = body.span(class: "frs-author-name-wrap").element(tag_name: "a").attribute_value("href")

    puts title, link, author, author_link
    puts "<----------------------------->"
  end

  # unless liArray[0].span(class: ["pull_right", "label_text"]).exists? && liArray[0].span(class: ["pull_right", "label_text"]).text === "广告"
  #   puts liArray[0].div(class: "threadlist_lz").a(class: "j_th_tit ").text, "<-------title"
  #   puts liArray[0].div(class: "threadlist_lz").span(class: "tb_icon_author").attribute_value("title"), "<-----author name"
  #   puts liArray[0].div(class: "threadlist_lz").span(class: "frs-author-name-wrap").element(tag_name: "a").attribute_value("href"), "<-----author link"
  #   puts liArray[0].div(class: "threadlist_lz").element(tag_name: "a").attribute_value("href"), "<-----tie zi link"
  # end
#   orderItem = liArray.find { |item| item.tag_name === "span"}
#   order = orderItem ? orderItem.text : nil 
  
#   news = liArray.find { |item| item.tag_name === "a"}
#   url = news.attribute_value("href")

#   unless url.nil?
#     { 
#       index: order,
#       url: url,
#       text: news.text
#     }
#   end
end

# p result

zhibo8.quit