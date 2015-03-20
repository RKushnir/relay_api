class CreateUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end

  def change
    create_table :users do |t|
      t.string :name

      t.timestamps null: false
    end

    User.reset_column_information
    User.create!([
      {name: 'Василь'},
      {name: 'Петро'},
      {name: 'Степан'},
      {name: 'Іван'},
      {name: 'Левко'},
    ])
  end
end
