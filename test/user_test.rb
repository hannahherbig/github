require File.expand_path('teststrap', File.dirname(__FILE__))

context :User do
  setup { GitHub.user("mytestuser") }

  asserts_topic.size 1
  asserts(:login).equals "mytestuser"
  asserts(:name).equals "test user"
  asserts_topic.size GitHub::User.properties.size

  context "first follower" do
    setup { topic.followers.first }

    asserts_topic.size 3
    asserts(:name)
    asserts_topic.size GitHub::User.properties.size
  end
end
