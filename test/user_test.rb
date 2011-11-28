require File.expand_path('teststrap', File.dirname(__FILE__))

context "User andrew12" do
  setup { GitHub.user("andrew12") }

  asserts(:exists?)

  context "followers" do
    setup { topic.followers }

    asserts_topic.kind_of Array

    asserts(:first).size 4
    asserts(:first).kind_of GitHub::User
  end

  context "following" do
    setup { topic.following }

    asserts_topic.kind_of Array

    asserts(:first).size 4
    asserts(:first).kind_of GitHub::User
  end

  context "organizations" do
    setup { topic.organizations }

    asserts_topic.kind_of Array
    asserts(:first).size 4
    asserts(:first).kind_of GitHub::Organization
  end

  context "repositories" do
    setup { topic.repositories }

    asserts_topic.kind_of Array
    asserts(:first).kind_of GitHub::Repository
  end
end
