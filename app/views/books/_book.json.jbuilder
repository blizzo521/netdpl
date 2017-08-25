json.extract! book, :id, :title, :isbn, :thumbnail, :author, :summary, :created_at, :updated_at
json.url book_url(book, format: :json)
