class CreateComments < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end
  class Post < ActiveRecord::Base
    has_many :comments
  end
  class Comment < ActiveRecord::Base
    belongs_to :author, class_name: 'User'
    belongs_to :post
  end

  def change
    create_table :comments do |t|
      t.text :text
      t.references :post, index: true, foreign_key: true
      t.references :author, index: true, foreign_key: true

      t.timestamps null: false
    end

    User.reset_column_information
    Post.reset_column_information
    Comment.reset_column_information

    users = User.all

    words = %w[Закон дозволяє українській розвідці закуповувати і застосовувати технічні засоби розвідки та спеціальні технічні засоби проникати в міжнародні терористичні злочинні групи чи організації а також організації що здійснюють підривну діяльність проти України з метою попередження чи припинення їхньої протиправної діяльності та встановлення осіб які їм сприяють]

    Post.find_each do |post|
      3.times { post.comments.create!(author: users.sample, text: words.sample(10).join(' ')) }
    end
  end
end
