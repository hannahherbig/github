require File.expand_path('teststrap', File.dirname(__FILE__))

context "Organization malkier" do
  setup { GitHub.org("malkier") }

  asserts(:exists?)

  context "members" do
    setup { topic.members }

    asserts_topic.kind_of Array

    asserts(:first).size 4
    asserts(:first).kind_of GitHub::User
  end

  context "repositories" do
    setup { topic.repositories }

    asserts_topic.kind_of Array
    asserts(:first).kind_of GitHub::Repository
  end
end
