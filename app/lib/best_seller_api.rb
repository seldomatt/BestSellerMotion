class BestSellerApi

  def self.root_url
    "http://api.nytimes.com/svc/books/v2/lists/best-sellers/history.json"
  end

  def self.search(query, scope, &block)
    BW::HTTP.get(root_url, {payload: build_search_payload(query, scope)}) do |response|
      if response.ok?
        data = BW::JSON.parse(response.body)
        block.call(data)
      else
        block.call(nil, true)
      end
    end
  end

  def self.build_search_payload(query, scope)
    query = query.downcase if scope == "Author" || scope == "Title"
    {
      scope.downcase => query,
      "api-key" => ENV["API_KEY"]
    }
  end

end