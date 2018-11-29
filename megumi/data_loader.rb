# Load File Data
module Megumi

  # Megumi::DataLoader.load_all()
  # Megumi::DataLoader.load_env("prod")
  # Megumi::data
  class DataLoader
    include Helper
    attr_reader :data

    def initialize
      @data = {}
    end

    def refresh
      load_all
    end

    def read_file(path)
      YAML.load_file(path)
    end

    def load_all
      Dir.chdir('config') do
        arr = Dir['*'].each { |env| load_env(env) }
      end
      # arr.each{ |env| }
    end

    def load_env(env)
      all = read_file("#{env}/all.yml")
      Dir.chdir("#{env}") do
        env_data = Dir['[^all]*.yml'].map do |f|
          [f[0..-5], deep_merge(all, read_file(f))]
        end
        @data[env] = { 'all' => all }.merge!(env_data.to_h)
      end
    end
  end

end
