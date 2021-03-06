require "./lib/task"
require "./lib/list"

def main_menu

  @current_list_index = 0

  puts "This application creates new to-do lists and adds tasks to those lists"

  loop do

    puts "\n"
    puts "List operations:"
    puts "  +l = add a list"
    puts "   l = lists all available lists"
    puts "Task operations:"
    puts "  +t = add a task to the current list"
    puts "   t = lists all of the tasks for the current list"
    puts "   c = shows all of the completed tasks for all available lists"
    puts "   s = sort the list of tasks"
    puts "   d = mark a task in the list as complete"
    puts "   x = delete a task from the list"
    puts "   r = change the description of a task"
    puts "Other operations:"
    puts "   m = return to the main menu (this menu)"
    puts "   q = quit the program"
    puts "\n"

    choice = gets.chomp.downcase

    if choice == "+l"
      add_list
    elsif choice == "l"
      list_lists
    elsif choice == "+t"
      add_task
    elsif choice == "t"
      list_tasks
    elsif choice == "c"
      completed_tasks
    elsif choice == "s"
      sort_tasks
    elsif choice == "d"
      change_a_task("d")
    elsif choice == "x"
      change_a_task("x")
    elsif choice == "r"
      change_a_task("r")
    elsif choice == "q"
      puts "End of to_do list program"
      puts "\n"
      exit
    elsif choice != "m"
      puts "Invalid input, please try again!"
      puts "\n"
    end
  end
end


def add_list
  puts "Enter a name for your new list"
  list_name = gets.chomp
  List.new(list_name).save
  @current_list_index = List.all.length-1
end


def add_task

  if List.all.empty?
    puts "No lists entered yet!"
  else
    this_list = List.by_index (@current_list_index)
    puts "Enter a name for a new task for #{this_list.list_name}"
    task_name = gets.chomp
    puts "Enter a priority (1 lowest - 5 highest) for the new task"
    priority = gets.chomp.to_i
    puts "Enter a due date (format yyyy-mm-dd) for the new task"
    due_date = gets.chomp
    new_task = Task.new(task_name, priority, due_date)
    this_list.add_task(new_task)
  end

end


def list_lists

  if List.all.empty?
    puts "No lists entered yet!"
  else
    List.all.each_with_index do |list, index|
      puts "#{index+1}. #{list.list_name}"
    end
    puts"\n"
    if List.all.length > 1
      puts "Enter the number of a list to which you want to go."
      list_number = gets.chomp.to_i
      @current_list_index = list_number-1
      this_list = List.by_index(@current_list_index)
      puts "You have chosen #{this_list.list_name}"
    end
  end
  puts "\n"
end


def list_tasks

  if List.all.empty?
    puts "No lists entered yet!"
  else
    this_list = List.by_index(@current_list_index)
    if this_list.tasks.empty?
      puts "No tasks entered yet!"
    else
      puts "The tasks for #{this_list.list_name} are:"
      this_list.tasks.each_with_index do |element, index|
        if !element.is_done?
          puts "#{index+1}. #{element.description}, priority = #{element.priority.to_s}, " +
               "due date = #{element.due_date}, completed = #{element.is_done?.to_s}"
        end
      end
    end
  end
end


def sort_tasks
  if List.all.empty?
    puts "There are no lists to check"
  else
    this_list = List.by_index(@current_list_index)
    list_tasks
    puts "\n"
    puts "Sort operations:"
    puts "   1 = sort the tasks by priority"
    puts "   2 = sort the tasks by due date"
    puts "   3 = sort the tasks by task name"
    puts "\n"
    option = gets.chomp
    if option == "1" || option == "2" || option == "3"
      this_list.sort_tasks(option.to_i)
      if option == "1"
        puts "Sorted by priority"
      elsif option == "2"
        puts "Sorted by due date"
      elsif option == "3"
        puts "Sorted by task name"
      end
      list_tasks
    else
      puts "Invalid sort option, please try again!"
      sort_tasks
    end
  end
end


def change_a_task(option)

  if List.all.empty?
    puts "There are no lists to check"
  else
    this_list = List.by_index(@current_list_index)
    list_tasks
    puts "Please enter the number of the task you would like to change"
    task_to_change = gets.chomp.to_i
    if task_to_change > this_list.tasks.length || task_to_change == 0
      puts "Invalid task number"
    elsif option == "d"
      this_list.tasks[task_to_change-1].mark_as_done
      puts "Task #{this_list.tasks[task_to_change-1].description} marked as complete"
    elsif option == "r"
      puts "Please enter the new description of the task"
      new_desc = gets.chomp
      this_list.tasks[task_to_change-1].set_description (new_desc)
      puts "Task #{this_list.tasks[task_to_change-1].description} has a new description"
    elsif option == "x"
      puts "Task #{this_list.tasks[task_to_change-1].description} has been deleted"
      this_list.tasks.delete_at(task_to_change-1)
    end
    list_tasks
  end
end


def completed_tasks

  if List.all.empty?
    puts "There are no lists to check"
  else
    puts "The completed tasks for all lists are:"
    List.all.each do |list|
      puts "List: #{list.list_name}"
      count = 0
      list.tasks.each_with_index do |element, index|
        if element.is_done?
          count += 1
          puts "    #{index+1}. #{element.description}, priority = #{element.priority.to_s}, " +
             "due date = #{element.due_date}, completed = #{element.is_done?.to_s}"
        end
      end
      if count == 0
        puts "    No completed tasks for this list"
      end
    end
  end
  puts "\n"
end

main_menu
