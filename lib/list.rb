class List

  @@all_lists = []

  def List.clear
    @@all_lists = []
  end

  def List.by_index (index)
    @@all_lists[index]
  end

  def List.all
    @@all_lists
  end

  def add
    @@all_lists << self
  end

  def initialize (list_name)
    @list_name = list_name
    @tasks = []
  end

  def list_name
    @list_name
  end

  def tasks
    @tasks
  end

  def add_task(new_task)
    @tasks << new_task
  end

  def sort_tasks(option)
    if option == 1
      @tasks.sort! {|task_a, task_b| task_b.priority <=> task_a.priority }
    else # option == 2
      @tasks.sort! {|task_a, task_b| task_a.due_date <=> task_b.due_date }
    end
  end
end
