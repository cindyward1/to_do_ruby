require "date"

class Task
  def initialize (description, priority, due_date)
    @description = description

    if priority == 0
      @priority = 1
    else
      @priority = priority.to_i
    end

    if due_date == ""
      @due_date = Date::today
    else
      puts "due_date = " + due_date
      @due_date = Date.parse(due_date)
    end

    @finished = false

  end

  def description
    @description
  end

  def priority
    @priority
  end

  def due_date
    @due_date
  end

  def is_done?
    @finished
  end

  def mark_as_done
    @finished = true
  end

end
