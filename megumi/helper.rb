module Megumi
  module Helper

  # http://apidock.com/rails/Hash/deep_merge
  # https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/hash/deep_merge.rb
  # merge hash, new_hash into old_hash
  def deep_merge(old_h, new_h)
    deep_merge!(old_h.dup, new_h)
  end

  # merge hash without dup, new_hash into old_hash
  def deep_merge!(old_h, new_h)
    new_h.each_pair do |key, new_value|
      old_value = old_h[key]

      old_h[key] = if old_value.is_a?(Hash) && new_value.is_a?(Hash)
                     deep_merge(old_value, new_value)
                   else
                     new_value
                   end
    end

    old_h
  end

  end
end