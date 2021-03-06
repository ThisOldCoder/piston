require File.dirname(__FILE__) + "/../test_helper"

class TestSvnRepositoryAt < Test::Unit::TestCase
  def setup
    @repos = Piston::Svn::Repository.new("http://bla.com/svn/repos/trunk")
  end

  def test_instantiate_revision_at_head
    Piston::Svn::Revision.expects(:new).with(@repos, "HEAD").returns(:newrev)
    assert_equal :newrev, @repos.at(:head)
  end
end
