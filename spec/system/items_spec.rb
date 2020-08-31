require 'rails_helper'

RSpec.describe '商品の出品', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end
  context '商品の出品ができる時' do
    it 'ログインしたユーザーは商品を出品する事ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 出品するボタンがある
      expect(page).to have_content('出品する')
      # 出品ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      attach_file 'item[images][]', "#{Rails.root}/spec/fixtures/test_image.png"
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.content
      find('#item-category').find("option[value='2']").select_option
      find('#item-sales-status').find("option[value='2']").select_option
      find('#item-shipping-fee-status').find("option[value='2']").select_option
      find('#item-prefecture').find("option[value='2']").select_option
      find('#item-scheduled-delivery').find("option[value='2']").select_option
      fill_in 'item-price', with: @item.price
      # 送信するとItemモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)
      # 出品が完了するとトップページへ遷移する
      expect(current_path).to eq root_path
      # トップページに出品した商品の画像が存在することを確認する
      expect(page).to have_selector("img[src$='test_image.png']")
      # トップページに出品した商品の商品名が存在することを確認する
      expect(page).to have_content(@item.name)
      # トップページに出品した商品の価格が存在することを確認する
      expect(page).to have_content(@item.price)
    end
  end
  context '商品の出品ができない時' do
    it 'ログインしていないユーザーは出品ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 出品するボタンがある
      expect(page).to have_content('出品する')
      # 出品するボタンをクリックしたらログインページへ遷移する
      visit new_item_path
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '出品した商品の編集', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '商品の編集ができるとき' do
    it 'ログインしたユーザーは自分が出品した商品の編集ができる' do
      # 商品1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品1の詳細ページに移動する
      visit item_path(@item1)
      # 「商品の編集」ボタンがあることを確認する
      expect(page).to have_link '商品の編集', href: edit_item_path(@item1)
      # 商品編集ページへ遷移する
      visit edit_item_path(@item1)
      # すでに出品済みの商品の内容がフォームに入っていることを確認する
      expect(
        find('#item-name').value
      ).to eq @item1.name
      expect(
        find('#item-info').value
      ).to eq @item1.content
      expect(
        find('#item-category').value
      ).to eq @item1.category_id.to_s
      expect(
        find('#item-sales-status').value
      ).to eq @item1.status_id.to_s
      expect(
        find('#item-shipping-fee-status').value
      ).to eq @item1.delivery_fee_id.to_s
      expect(
        find('#item-prefecture').value
      ).to eq @item1.shipping_region_id.to_s
      expect(
        find('#item-scheduled-delivery').value
      ).to eq @item1.days_until_shipping_id.to_s
      expect(
        find('#item-price').value
      ).to eq @item1.price.to_s
      # 商品の内容を編集する（商品名と価格を編集し確認する）
      fill_in 'item-name', with: "#{@item1.name}+(編集しました)"
      fill_in 'item-price', with: (@item1.price + 1000).to_s
      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 編集完了後、詳細ページ遷移したことを確認する
      expect(current_path).to eq item_path(@item1)
      # トップページに遷移する
      visit root_path
      # トップページに編集した商品の商品名が存在することを確認する
      expect(page).to have_content("#{@item1.name}+(編集しました)")
      # トップページに編集した商品の価格が存在することを確認する
      expect(page).to have_content((@item1.price + 1000).to_s)
    end
  end
  context '商品の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の編集画面には遷移できない' do
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品2の詳細ページに移動する
      visit item_path(@item2)
      # 「商品の編集」ボタンがないことを確認する
      expect(page).to have_no_link '商品の編集', href: edit_item_path(@item1)
      # URLを直接入力してもトップページへリダイレクトされる
      visit edit_item_path(@item2)
      expect(current_path).to eq root_path
    end
    it 'ログインしていないと商品の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 商品1の詳細ページへ移動する(ログインしていなくても詳細ページは見る事ができる)
      visit item_path(@item1)
      # 「商品の編集」ボタンがないことを確認する
      expect(page).to have_no_link '商品の編集', href: edit_item_path(@item1)
      # URLを直接入力するとログインページへ遷移する
      visit edit_item_path(@item2)
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '出品した商品の削除', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '商品の削除ができるとき' do
    it 'ログインしたユーザーは自らが出品した商品の削除ができる' do
      # 商品1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品1の詳細ページに移動する
      visit item_path(@item1)
      # 「削除」ボタンがあることを確認する
      expect(page).to have_link '削除', href: item_path(@item1)
      # 出品した商品を削除するとレコードの数が1減ることを確認する
      expect do
        find_link('削除', href: item_path(@item1)).click
      end.to change { Item.count }.by(-1)
      # 削除が完了するとトップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # トップページに遷移する
      visit root_path
      # トップページには商品1の画像が存在しないことを確認する
      expect(page).to have_no_selector("item-img[src$='test_image.png']")
    end
  end
  context '商品の削除ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の削除ができない' do
      # 商品1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      # 商品2の詳細ページへ移動する
      visit item_path(@item2)
      # 商品2に「削除」ボタンがないことを確認する
      expect(page).to have_no_link '削除', href: item_path(@item2)
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # 商品1の詳細ページへ移動する
      visit item_path(@item1)
      # 商品1に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: item_path(@item1)
      # トップページへ戻る
      visit root_path
      # 商品2の詳細ページへ移動する
      visit item_path(@item2)
      # 商品2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: item_path(@item2)
    end
  end
end
