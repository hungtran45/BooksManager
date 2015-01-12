json.array!(@books) do |book|
  json.extract! book, :id, :title, :year, :category, :author
  json.url book_url(book, format: :json)
end
