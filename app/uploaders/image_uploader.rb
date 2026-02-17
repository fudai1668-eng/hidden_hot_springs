class ImageUploader < CarrierWave::Uploader::Base
  # 本番環境(Render)ではCloudinaryを使用
  if Rails.env.production?
    include Cloudinary::CarrierWave
  else
    storage :file
  end

  # ↓↓↓ このブロックは不要（またはエラーの原因になる可能性がある）なので削除かコメントアウトを推奨 ↓↓↓
  # CarrierWave.configure do |config|
  #   config.cache_storage = :file
  # end
  # ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

  # 本番環境での一時保存先を、書き込み権限のある /tmp に変更する
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # 保存先のディレクトリ（Cloudinary使用時は無視されますが、ローカル用に残しておいてOK）
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end