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
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it 'imagesが空だと出品できない' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('画像を入力してください')
      end
      it 'contentが空だと出品できない' do
        @item.content = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'category_idが空だと出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'status_idが空だと出品できない' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'delivery_fee_idが空だと出品できない' do
        @item.delivery_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'shipping_region_idが空だと出品できない' do
        @item.shipping_region_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'days_until_shipping_idが空だと出品できない' do
        @item.days_until_shipping_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'priceが空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格を入力してください')
      end
      it 'priceが300円以下だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は規定の範囲外です')
      end
      it 'priceが9,999,999円以上だと出品できない' do
        @item.price = 100_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は規定の範囲外です')
      end
    end
  end
end
