require "rspec"
require "task"
require "list"

describe(Task) do

  it("is initialized with a description") do
    test_task = Task.new("Learn Ruby",1,"2014-07-29")
    test_task.should be_an_instance_of Task
  end

  it 'shows the description' do
    test_task = Task.new("Learn Ruby",1,"2014-07-29")
    test_task.description.should eq 'Learn Ruby'
  end

  it "marks the task as done" do
    test_task = Task.new("Learn Ruby",1,"2014-07-29")
    test_task.mark_as_done
    test_task.is_done?.should eq true
  end

end


describe(List) do

  before do
    List.clear
  end

  it("starts out with an empty list of tasks") do
    test_list = List.new("School stuff")
    test_list.tasks.should eq []
  end

  it("can add tasks") do
    test_list = List.new("School stuff")
    test_task = Task.new("Learn Ruby",1,"2014-07-29")
    test_list.add_task(test_task)
    test_list.tasks.should eq [test_task]
  end

  it "is empty at first" do
    List.all.should eq []
  end

  it "adds a list to the array of lists" do
    test_list = List.new("School stuff")
    test_list.add
    List.all.should eq [test_list]
  end

  it "returns a list by index number" do
    test_list = List.new("School stuff")
    test_list.add
    List.by_index(0).should eq test_list
  end

  it "clears the array of lists" do
    test_list = List.new("School stuff")
    test_list.add
    List.clear
    List.all.should eq []
  end

end
