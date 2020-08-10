class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name,                null: false
      t.text       :image,               null: false
      t.text       :content,             null: false
      t.integer    :category,            null: false
      t.integer    :status,              null: false
      t.integer    :price,               null: false
      t.integer    :delivery_fee,        null: false
      t.integer    :shipping_region,     null: false
      t.integer    :days_until_shipping, null: false
      t.references :user_id,             forign_key: true
      t.timestamps
    end
  end
end
