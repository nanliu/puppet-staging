Facter.add("staging_http_get") do
  setcode do

    which = lambda do |cmd|
      exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
      locations = ENV['PATH'].split(File::PATH_SEPARATOR).flat_map do |path|
        exts.map do |ext|
          File.join(path, "#{cmd}#{ext}")
        end
      end
      locations.find { |loc| File.executable? loc }
    end

    ['powershell', 'curl', 'wget'].find { |cmd| which.call(cmd) }

  end
end
