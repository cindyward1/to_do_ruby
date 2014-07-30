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
end
