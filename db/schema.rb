ActiveRecord::Schema.define(:version => 1) do
  create_table "books", :force => true do |t|
    t.integer    "isbn",   :null => false
    t.string     "title",   :null => false
    t.text       "description"
    t.text       "contents"
    t.binary     "full_text"
    t.datetime   "published_at"
    t.integer    "category_id"
    t.integer    "author_id"
  end

  add_index "books", ["published_at"], :name => "index_books_on_published_at"

  create_table "categories" do |t|
    t.string :name
  end


  create_table "authors" do |t|
    t.string "name"
  end


end