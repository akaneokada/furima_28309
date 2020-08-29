require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  # 変数を定義して画像の枚数を変えられるようにする
  let(:image_path) { Rails.root.join('spec/fixtures/test_image.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  describe '商品出品機能' do
    context '商品の出品が成功する場合' do
      it '全て正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end

      it '画像が2枚でも出品できる' do
        @item = FactoryBot.build(:item, images: [image, image])
        expect(@item).to be_valid
      end
    end

    context '商品の出品が失敗する場合' do
      it 'nameが空だと出品できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'imagesが空だと出品できない' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Images can't be blank")
      end
      it 'contentが空だと出品できない' do
        @item.content = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'category_idが空だと出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'status_idが空だと出品できない' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it 'shipping_region_idが空だと出品できない' do
        @item.shipping_region_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping region can't be blank")
      end
      it 'days_until_shipping_idが空だと出品できない' do
        @item.days_until_shipping_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Days until shipping can't be blank")
      end
      it 'priceが空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300円以下だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it 'priceが9,999,999円以上だと出品できない' do
        @item.price = 100_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
    end
  end
end
