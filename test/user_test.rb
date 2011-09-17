require File.expand_path('teststrap', File.dirname(__FILE__))

context :User do
  setup { GitHub.user("mytestuser") }

  asserts_topic.size 1
  asserts(:login).equals "mytestuser"
  asserts(:name).equals "test user"

  context "first follower" do
    setup { topic.followers.first }

    asserts_topic.size 4
  end
end
