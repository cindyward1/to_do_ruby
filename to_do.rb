require "./lib/task"
require "./lib/list"

def main_menu

  @lists = []
  @current_list_index = 0

  puts "This application creates new to-do lists and adds tasks to those lists"

  loop do

    puts "\n"
    puts "To add a new list, enter '+l'. To add a new task to the current list, enter '+t'."
    puts "To delete a list, enter '-l'. To delete a task, enter '-t'."
    puts "To see a list of all of your lists, enter 'l'."
    puts "To see all the tasks for the current list, enter't'."
    puts "To see the completed tasks for all of your lists, enter 'c'."
    puts "\n"

    choice = gets.chomp

    if choice == "+l"
      add_list
    elsif choice == "+t"
      add_task
    elsif choice == "-l"
      delete_list
    elsif choice == "-t"
      delete_task
    elsif choice == "l"
      list_lists
    elsif choice == "t"
      list_tasks
    elsif choice == "c"
      completed_tasks
    elsif choice == "x"
      puts "End of to_do list program"
      exit
    else
      puts "Invalid input, please try again!"
      puts "\n"
    end

  end

end

def add_list
  puts "Enter a name for your new list"
  list_name = gets.chomp
  @lists << List.new(list_name)
end

def add_task
  puts "Enter a name for a new task for #{@lists[@current_list_index].list_name}"
  task_name = gets.chomp
  puts "Enter a priority (1 lowest - 5 highest) for the new task"
  priority = gets.chomp.to_i
  puts "Enter a due date (format yyyy-mm-dd) for the new task"
  due_date = gets.chomp
  new_task = Task.new(task_name, priority, due_date)
  @lists[@current_list_index].add_task(new_task)
end

def list_lists

  if @lists.empty?
    puts "No lists entered yet!"
  else
    @lists.each_with_index do |list, index|
      puts "#{index+1}. #{list.list_name}"
    end
    puts"\n"
    puts "Choose a number of a list you want to go to."
    list_number = gets.chomp.to_i
    @current_list_index = list_number-1
    puts "You have chosen #{@lists[@current_list_index].list_name}"
  end
  puts "\n"
end

def list_tasks
  if @lists[@current_list_index].tasks.empty?
    puts "No tasks entered yet!"
  else
    puts "The tasks for #{@lists[@current_list_index].list_name} are:"
    @lists[@current_list_index].tasks.each_with_index do |element, index|
      puts "#{index+1}. #{element.description}, priority = #{element.priority.to_s}, " +
             "due date = #{element.due_date}, completed = #{element.is_done?.to_s}"
    end
    puts "\n"
    puts "Do you want to sort the tasks by priority (enter '1') or due date (enter '2') " +
         "or not sort (enter 'n') or exit (enter 'x')"
    option = gets.chomp
    if option == "1" || option == "2"
      @lists[@current_list_index].sort_tasks(option.to_i)
      if option == "1"
        puts "The tasks for #{@lists[@current_list_index].list_name} sorted by priority are:"
      else
        puts "The tasks for #{@lists[@current_list_index].list_name} sorted by due date are:"
      end
      @lists[@current_list_index].tasks.each_with_index do |element, index|
        puts "#{index+1}. #{element.description}, priority = #{element.priority.to_s}, " +
             "due date = #{element.due_date}, completed = #{element.is_done?.to_s}"
      end
    elsif option != "n" && option != "x"
      puts "Invalid sort option"
    elsif option == "x"
      puts "End of to_do list program"
      exit
    else
      puts "Have you completed a task? If so, enter its number to mark it as finished."
      task_to_mark_complete = gets.chomp.to_i
      if task_to_mark_complete > @lists[@current_list_index].tasks.length || task_to_mark_complete == 0
        puts "Invalid task number"
      else
        @lists[@current_list_index].tasks[task_to_mark_complete-1].mark_as_done
      end
    end
  end

  def completed_tasks

  if @lists.empty?
    puts "There are no lists to check"
  else
    index_list = 0
    puts "The completed tasks for all lists are:"
    @lists.each_with_index do |list, index|
      puts "   List: #{list.list_name}"
      @lists[index].tasks.each_with_index do |element, index|
        if element.is_done?
          puts "#{index_list+1}. #{element.description}, priority = #{element.priority.to_s}, " +
             "due date = #{element.due_date}, completed = #{element.is_done?.to_s}"
          index_list += 1
        end
      end
    end
  end
  puts "\n"
end

end

main_menu
