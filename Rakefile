require "bundler"
Bundler.setup

require "rspec/core/rake_task"
Rspec::Core::RakeTask.new(:spec)

gemspec = eval(File.read("virtual_attribute.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["virtual_attribute.gemspec"] do
  system "gem build virtual_attribute.gemspec"
  system "gem install virtual_attribute-#{VirtualAttribute::VERSION}.gem"
end
