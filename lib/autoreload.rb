require 'fssm'

Thread.abort_on_exception = true

Thread.new do
  FSSM.monitor(File.expand_path('.', File.dirname(__FILE__)), '**/*') do
    block = proc do |b, r|
      fn = File.join(b, r)
      load fn
      puts "reloaded #{fn}"
    end

    update &block
    create &block
  end
end
