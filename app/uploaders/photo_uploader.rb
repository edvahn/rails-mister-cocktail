class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url
    "/assets/fallback/" + [version_name, "default.png"].compact.join('_')
  end
  # Remove everything else
end
