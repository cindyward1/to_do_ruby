class List

  @@all_lists = []

  def initialize (list_name)
    @list_name = list_name
    @tasks = []
  end

  def List.clear
    @@all_lists = []
  end

  def List.by_index (index)
    @@all_lists[index]
  end

  def List.all
    @@all_lists
  end

  def save
    @@all_lists << self
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
    elsif option == 2
      @tasks.sort! {|task_a, task_b| task_a.due_date <=> task_b.due_date }
    elsif option == 3
      @tasks.sort! {|task_a, task_b| task_a.description <=> task_b.description }
    end
  end
end
