class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :email
      t.boolean :subscribed

      t.timestamps
    end
  end
end
