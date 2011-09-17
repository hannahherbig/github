require File.expand_path('teststrap', File.dirname(__FILE__))

context "User" do
  setup { GitHub.user("mytestuser") }

  asserts(:login).equals "mytestuser"


  context "followers" do
    setup { topic.followers }
    asserts_topic.size 1
  end
end