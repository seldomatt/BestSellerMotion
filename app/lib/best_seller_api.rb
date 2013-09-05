class BestSellerApi

  def self.root_url
    "http://api.nytimes.com/svc/books/v2/lists/best-sellers/history.json"
  end

  def self.search(query, scope, offset=0, &block)
    BW::HTTP.get(root_url, {payload: build_search_payload(query, scope, offset)}) do |response|
      if response.ok?
        data = BW::JSON.parse(response.body)
        block.call(data)
      else
        block.call(nil, "Something went wrong")
      end
    end
  end

  def self.build_search_payload(query, scope, offset)
    query = query.downcase if scope == "Author" || scope == "Title"
    {
      scope.downcase => query,
      "api-key" => ENV["API_KEY"],
      "offset" => offset
    }
  end

end