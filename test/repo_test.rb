require File.expand_path('teststrap', File.dirname(__FILE__))

context "Repository malkier/kythera" do
  setup { GitHub.repo("malkier", "kythera") }

  asserts(:exists?)
  asserts(:owner).kind_of GitHub::Organization
end
